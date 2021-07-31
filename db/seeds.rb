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

jana = User.create(
    first_name: "Jana",
    last_name: "Moudra",
    email: "jana@proman.com",
    password: "123456"
)

tomas = User.create(
    first_name: "Tomas",
    last_name: "Jukin",
    email: "tomas@proman.com",
    password: "123456"
)

vojtech = User.create(
    first_name: "Vojtech",
    last_name: "Matous",
    email: "vojtech@proman.com",
    password: "123456"
)

counter = 1
10.times do 
    project = Project.create(
        title: Faker::Company.name,
        user_id: [jana, tomas, vojtech].sample.id,
        position: rand(100)
    )
    puts "Created seed number --> #{counter} <-- with title --> #{project.title} <--"
    counter += 1
end

puts "Done creating seeds!"