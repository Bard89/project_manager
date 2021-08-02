# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Clearing database from Users and Projects and Tasks"
# the order matters -> be careful with this -> more here: https://stackoverflow.com/questions/48739646/pgforeignkeyviolation-error-update-or-delete-on-table-xxx-violates-foreign
Task.destroy_all
User.destroy_all
Project.destroy_all

puts "Dratabase cleared"


puts "---Creating seeds"
puts "..."
counter = 0
puts
jana = User.create(
    first_name: "Jana",
    last_name: "Moudra",
    email: "jana@proman.com",
    password: "123456"
)
counter += 1
puts "User seed named --> #{jana.first_name} <-- created"

tomas = User.create(
    first_name: "Tomas",
    last_name: "Jukin",
    email: "tomas@proman.com",
    password: "123456"
)
counter += 1
puts "User seed named --> #{tomas.first_name} <-- created"


vojtech = User.create(
    first_name: "Vojtech",
    last_name: "Matous",
    email: "vojtech@proman.com",
    password: "123456"
)
counter += 1
puts "User seed named --> #{vojtech.first_name} <-- created"
puts
puts "Total number of user seeds --> #{counter} <--"

puts
puts 
counter = 0
30.times do 
    project = Project.create(
        title: "Project #{Faker::Company.name}",
        user_id: [jana, tomas, vojtech].sample.id,
        position: rand(100)
    )
    puts "Created project seed id --> #{project.id} <-- with title --> #{project.title} <--"
    counter += 1
end

puts
puts "Total number of project seeds --> #{counter} <--"


puts
puts
counter = 0
150.times do 
    user_id_for_project = [jana, tomas, vojtech].sample.id
    task = Task.create(  #won't be created for some reason
        title: "task #{Faker::Beer.name} ",
        description: "task-description #{Faker::GreekPhilosophers.quote}",
        is_done: [false, true].sample, # here is the problem, seed won't get created with is_done set to false -> because of the wrongly set validation, be careful with that boi
        # attachement: file .... 
        user_id: user_id_for_project,
        project_id: Project.where(user_id: user_id_for_project).sample.id
    )
    puts "Created taks seed id --> #{task.id} <-- with title --> #{task.title} <--"
    counter += 1
end
puts
puts "Total number of task seeds --> #{counter} <--"

puts
puts "..."
puts "Done creating seeds!"