puts "Clearing database from Users and Projects and Tasks"
# the order matters -> be careful with this -> more here: https://stackoverflow.com/questions/48739646/pgforeignkeyviolation-error-update-or-delete-on-table-xxx-violates-foreign
TagTask.destroy_all
Tag.destroy_all
Task.destroy_all
User.destroy_all
Project.destroy_all

puts "Dratabase cleared"

puts "---Creating seeds"
puts "..."
counter = 0
puts
# If we need an ActiveRecord method to raise an exception instead of a false value in case of failure, we can add ! to them.
# https://wikitechy.com/tutorials/ruby-on-rails/activerecord-bang-methods-in-ruby-on-rails
jana = User.create!( # without the --> ! <-- would not give us any feedback
    first_name: "Jana",
    last_name: "M.",
    email: "jana@proman.com",
    password: "123456",
    admin: false
)
counter += 1
puts "User seed named --> #{jana.first_name} <-- created"

tomas = User.create!(
    first_name: "Tomas",
    last_name: "J.",
    email: "tomas@proman.com",
    password: "123456",
    admin: false
)
counter += 1
puts "User seed named --> #{tomas.first_name} <-- created"


vojtech = User.create!(
    first_name: "Vojtech",
    last_name: "M.",
    email: "vojtech@proman.com",
    password: "123456",
    admin: false
)
counter += 1
puts "User seed named --> #{vojtech.first_name} <-- created"
puts
puts "Total number of user seeds --> #{counter} <--"

# next as the admin, with great power comes great responsibility
zeus = User.create!(
    first_name: "Zeus",
    last_name: "Admin",
    email: "zeus@proman.com",
    password: "123456",
    admin: true
)
counter += 1
puts "User seed named --> #{vojtech.first_name} <-- created"
puts
puts "Total number of user seeds --> #{counter} <--"

puts
puts 
counter = 0
100.times do 
    project = Project.create!(
        title: "#{Faker::Fantasy::Tolkien.poem}",
        user_id: [jana, tomas, vojtech, zeus].sample.id,
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
700.times do 
    user_id_for_project = [jana, tomas, vojtech, zeus].sample.id
    task = Task.create!( 
        title: "#{Faker::Fantasy::Tolkien.location} ",
        description: "#{Faker::Quote.yoda}",
        is_done: [false, true].sample,
        # attachement: file .... 
        user_id: user_id_for_project,
        project_id: Project.where(user_id: user_id_for_project).sample.id
    )
    puts "Created task seed id --> #{task.id} <-- with title --> #{task.title} <--"
    counter += 1
end
puts
puts "Total number of task seeds --> #{counter} <--"

puts
puts

counter = 0

25.times do 
    user_id_for_tag = [jana, tomas, vojtech, zeus].sample.id
    tag = Tag.create!(
        title: "#{Faker::Team.creature} ",
        user_id: user_id_for_tag
    )
    puts "Created tags seed id --> #{tag.id} <-- with title --> #{tag.title} <--"
    counter += 1
end
puts
puts "Total number of tags seeds --> #{counter} <--"

counter = 0

1000.times do 
    user_id_for_task_tag = [jana, tomas, vojtech, zeus].sample.id
    tag_task = TagTask.create!(
        tag_id: Tag.where(user_id: user_id_for_task_tag).ids.sample,
        task_id: Task.where(user_id: user_id_for_task_tag).ids.sample
    )
    puts "Created tag_tasks seeds id --> #{tag_task.id} <--"
    counter += 1
end
puts
puts "Total number of tags seeds --> #{counter} <--"

puts
puts "..."
puts "Done creating seeds!"