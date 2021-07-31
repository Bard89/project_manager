# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database from Users and Gift requests"
User.destroy_all
Project.destroy_all
# Chatroom.destroy_all
# GiftRequest.destroy_all
# Chatroom.destroy_all

puts "---Creating seeds"
puts "..."

puts
jana = User.create(
    first_name: "Jana",
    last_name: "Moudra",
    email: "jana@proman.com",
    password: "123456"
)
puts "User seed named --> #{jana.first_name} <-- created"

tomas = User.create(
    first_name: "Tomas",
    last_name: "Jukin",
    email: "tomas@proman.com",
    password: "123456"
)
puts "User seed named --> #{tomas.first_name} <-- created"


vojtech = User.create(
    first_name: "Vojtech",
    last_name: "Matous",
    email: "vojtech@proman.com",
    password: "123456"
)
puts "User seed named --> #{vojtech.first_name} <-- created"


puts 
counter = 0
10.times do 
    project = Project.create(
        title: Faker::Company.name,
        user_id: [jana, tomas, vojtech].sample.id,
        position: rand(100)
    )
    puts "Created project seed id --> #{project.id} <-- with title --> #{project.title} <--"
    counter += 1
end

puts
puts "Total number of project seeds --> #{counter} <--"
puts "Done creating seeds!"