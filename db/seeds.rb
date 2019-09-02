require 'faker'
require 'json'
require 'http'

User.destroy_all

host = "twinword-word-graph-dictionary.p.rapidapi.com"
twin_key = ENV["TWINKEY"]
project_id = ENV["PROJECTID"]
regex = /(^.*$)/
regex2 = /(\(.{3}\))/

headers = {
  "x-rapidapi-host" => host,
  "x-rapidapi-key" => twin_key,
  "RapidAPIProject" => project_id
}

def set_url(category, word)
  base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
  url = "#{base + category}entry=#{word}"
end

def set_state(word)
  if !word.meaning.nou.blank?
    "nou"
  elsif !word.meaning.adj.blank?
    "adj"
  elsif !word.meaning.vrb.blank?
    "vrb"
  elsif !word.meaning.adv.blank?
    "adv"
  end
end

puts "creating user"
count = 1
user = User.new(
email: "vocation@gno.me",
password: "vocation",
username: Faker::Name.first_name
)
user.save!


lists_name = %w(Macro-Economie Droit Compta-Financiere Human-Sociology Macbeth Flexbox)
name_index = 0

puts "Using Faker to seed the DataBase"
6.times do
  puts "create list n° #{count}"
  list = List.new(
  title: lists_name[name_index],
  user: user,
  )
  list.save!

  puts "generating 15 random words for list #{list}"
  (5..18).to_a.sample.times do
    wl = WordsList.new(list: list)
    ww = UserWord.new(user: user)
    word = Word.new(
    entry: Faker::Creature::Cat.name,
    translation: Faker::Creature::Dog.name,
    definition: Faker::Quote.famous_last_words,
    example: Faker::Quote.most_interesting_man_in_the_world,
    nature: Faker::Verb.base,
    difficulty: (0..10).to_a.sample,
    synonyms: [Faker::Verb.past_participle, Faker::Verb.simple_present, Faker::Verb.ing_form],
    visible: [false, true].sample
    )
    word.save!
    ww.word = word
    wl.word = word
    ww.save!
    wl.save!
  end
  name_index += 1
  count += 1
end

week_count = 0
puts "Creating 4 fake lists of the week"
6.times do
  puts "create list for week n° #{29 + week_count}"
  list = List.new(
  title: "week #{29 + week_count}",
  user: user,
  week: week_count + 29
  )
  list.save!

  puts "generating random words for list #{list}"
  (5..18).to_a.sample.times do
    wl = WordsList.new(list: list)
    ww = UserWord.new(user: user)
    word = Word.new(
    entry: Faker::Creature::Cat.name,
    translation: Faker::Creature::Dog.name,
    definition: Faker::Quote.famous_last_words,
    example: Faker::Quote.most_interesting_man_in_the_world,
    nature: Faker::Verb.base,
    difficulty: (0..10).to_a.sample,
    synonyms: [Faker::Verb.past_participle, Faker::Verb.simple_present, Faker::Verb.ing_form],
    visible: [false, true].sample
    )
    word.save!
    ww.word = word
    wl.word = word
    ww.save!
    wl.save!
  end
  week_count += 1
end

list = List.new(title: "List of the week", user: user, week: Date.today.cweek)
list.save!

info = ["example/?", "difficulty/?", "definition/?", "reference/?"]
words = %w(fear other trust sheep cup sink blood smoke knowledge time)

puts "calling the API"
words.each_with_index do |word, index|
  base = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
  key = ENV["YANKEY"]
  languages = "en-fr"
  url = "#{base}lang=#{languages}&key=#{key}&text=#{word}"
  callback = JSON.parse(HTTP.get(url))
  puts callback["text"]
  translation = callback["text"].first

  wl = WordsList.new(list: list)
  ww = UserWord.new(user: user)
  puts "creating word n°#{index + 1}"
    puts "calling API for examples"
    callback = HTTP.get(set_url(info[0], word), headers: headers)
    response = JSON.parse(callback)
    example = response['example'].first(3) # retourne un array d'examples

  puts "calling API for difficulty level"
  callback = HTTP.get(set_url(info[1], word), headers: headers)
  response = JSON.parse(callback)
  difficulty = response["ten_degree"]

  puts "callin API for definitions"
  definition = Meaning.new
  callback = HTTP.get(set_url(info[2], word), headers: headers)
  response = JSON.parse(callback)
  response["meaning"].each do |nature, meaning|
    case nature
    when "noun"
      definition.nou = meaning.scan(regex).flatten unless meaning == ""
    when "verb"
      definition.vrb = meaning.scan(regex).flatten unless meaning == ""
    when "adverb"
      definition.adv = meaning.scan(regex).flatten unless meaning == ""
    when "adjective"
      definition.adj = meaning.scan(regex).flatten unless meaning == ""
    end
  end

  puts "calling API for references"
  reference = Reference.new
  callback = HTTP.get(set_url(info[3], word), headers: headers)
  response = JSON.parse(callback)
  synonyms = response["relation"].each do |relation, terms|
    unless terms == ""
      case relation
      when "broad_terms"
        reference.broad_terms = terms.split(',')
      when "narrow_terms"
        reference.narrow_terms = terms.split(',')
      when "related_terms"
        reference.related_terms = terms.split(',')
      when "synonyms"
        reference.synonyms = terms.split(',')
      end
    end
  end

  word = Word.new(
    entry: word,
    translation: translation,
    difficulty: difficulty,
    example: example,
  )
  definition.word = word
  reference.word = word
  reference.save!
  definition.save!
  word.save!
  ww.word = word
  wl.word = word
  ww.state = set_state(word)
  ww.save!
  wl.save!
end
print `clear`
puts "------------------ You can login to #{user.username}'s account with the following logs ------------------"
puts "------------------------------ email: #{user.email} || password: #{user.password} ------------------------------"
