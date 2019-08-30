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

info = ["example/?", "difficulty/?", "definition/?", "reference/?"]
words = %w(fear other trust sheep cup sink blood smoke knowledge time)

def set_url(category, word)
  base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
  url = "#{base + category}entry=#{word}"
end

puts "creating user"
count = 1
user = User.new(
email: "vocation@gno.me",
password: "vocation",
username: Faker::Name.first_name
)
user.save!

list = List.new(title: "List of the week", user: user, week: Date.today.cweek)
list.save!

puts "calling the API"
words.each_with_index do |word, index|
  base = "https://translate.yandex.net/api/v1.5/tr.json/translate?"
  key = ENV["YANKEY"]
  languages = "en-fr"
  url = "#{base}lang=#{languages}&key=#{key}&text=#{word}"
  callback = JSON.parse(HTTP.get(url))
  puts callback
  translation = callback["text"].first

  wl = WordsList.new(list: list)
  ww = UserWord.new(user: user)
  puts "creating word n°#{index + 1}"
  callback = HTTP.get(set_url(info[0], word), :headers => headers )
  response = JSON.parse(callback)
  example = response['example'].first # retourne un array d'examples

  callback = HTTP.get(set_url(info[1], word), :headers => headers )
  response = JSON.parse(callback)
  difficulty = response["ten_degree"]

  callback = HTTP.get(set_url(info[2], word), :headers => headers )
  response = JSON.parse(callback)
  definitions = response["meaning"].reject { |k, v| v == "" } # clean les key vides
  meanings = definitions.map { |k, v| regex.match(v)[1] } # ne prend que la premiere def par type (nom, verbe, adverbe, adjectif)
  natures = meanings.map { |i| regex2.match(i)[1].gsub(/\W/, '') }

  callback = HTTP.get(set_url(info[3], word), :headers => headers )
  response = JSON.parse(callback)
  synonyms = response["relation"]["broad_terms"].split(',').first(3)


  word = Word.new(
  entry: word,
  translation: translation,
  definition: meanings,
  nature: natures,
  difficulty: difficulty,
  example: example,
  synonyms: synonyms
  )
  word.save!
  ww.word = word
  wl.word = word
  ww.save!
  wl.save!
end


puts "Using Faker to seed the DataBase"
10.times do
  puts "create list n° #{count}"
  list = List.new(
  title: [Faker::Music.genre, Faker::Job.field].sample,
  user: user,
  )
  list.save!

  puts "generating 15 random words for list #{list}"
  15.times do
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
  count += 1
end

print `clear`

puts "------------------ You can login to #{user.username}'s account with the following logs ------------------"
puts "------------------------------ email: #{user.email} || password: #{user.password} ------------------------------"
