require 'faker'
require 'json'
require 'http'

base = "https://twinword-word-graph-dictionary.p.rapidapi.com/"
host = "twinword-word-graph-dictionary.p.rapidapi.com"
twin_key = ENV["TWINKEY"]
project_id = ENV["PROJECTID"]

info = ["example/?", "difficulty/?", "definition/?", "reference/?"]
words = %w(spinster chair glimpse peep warble show sheep dress hat grade)
entry = "mask"

url = "#{base + pos[0]}entry=#{entry}"
headers = {
  "x-rapidapi-host" => host,
  "x-rapidapi-key" => twin_key,
  "RapidAPIProject" => project_id
}

callback = HTTP.get(url, :headers => headers )

p JSON.parse(callback)

info.each do |i|
  url = "#{base + i}entry=#{entry}"
end
# url_example = "#{base + pos[:example]}entry=#{entry}x-rapidapi-host=#{host}x-rapidapi-key=#{twin_key}RapidAPIProject=#{project_id}"
# url_reference = "#{base + pos[:reference]}entry=#{entry}x-rapidapi-host=#{host}x-rapidapi-key=#{twin_key}RapidAPIProject=#{project_id}"

# callback = JSON.parse(open(url).read)
# p callback
# count = 1
# user = User.new(
# email: "vocation@gno.me",
# password: "vocation",
# username: Faker::Name.first_name
# )
# user.save!

# 10.times do
#   puts "create list n° #{count}"
#   list = List.new(
#   title: [Faker::Music.genre, Faker::Job.field].sample,
#   user: user
#   )
#   list.save!

#   wl = WordsList.new(list: list)
#   ww = UserWord.new(user: user)
#   puts "generating 15 random words for list #{list}"
#   15.times do
#     word = Word.new(
#     entry: Faker::Creature::Cat.name,
#     translation: Faker::Creature::Dog.name,
#     definition: Faker::Quote.famous_last_words,
#     example: Faker::Quote.most_interesting_man_in_the_world,
#     nature: Faker::Verb.base,
#     difficulty: (0..10).to_a.sample,
#     synonyms: [Faker::Verb.past_participle, Faker::Verb.simple_present, Faker::Verb.ing_form],
#     visible: [false, true].sample
#     )
#     word.save!
#     ww.word = word
#     wl.word = word
#   end
#   wl.save!
#   ww.save!
#   count += 1
# end

# puts "------------------ You can login to #{user.username}'s account with the following logs ------------------"
# puts "------------------------------ email: #{user.email} || password: #{user.password} ------------------------------"


