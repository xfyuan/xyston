# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times.each do
  password = Faker::Internet.password(14)
  User.create(
    name:                  Faker::Internet.user_name,
    email:                 Faker::Internet.email,
    password:              password,
    password_confirmation: password,
    firstname:             Faker::Name.first_name,
    lastname:              Faker::Name.last_name,
    admin:                 false
  )
end
