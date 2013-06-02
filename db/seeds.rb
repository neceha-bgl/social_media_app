# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end

puts 'ADMIN'
user = User.find_or_create_by_email :user_name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
user.add_role :admin

puts 'DEFAULT USERS'
100.times do |n|
  name = Faker::Name.name
  first_name , last_name = name.split
  email="#{last_name}-#{n}@social_media_app.com"
  password="password"
  user = User.create!(user_name: name,
                      first_name: first_name,
                      last_name: last_name,
                      email: email,
                      password: password,
                      password_confirmation: password)
  user.add_role :VIP
end

