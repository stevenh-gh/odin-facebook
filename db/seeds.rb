# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

steven = User.create(name: 'steven', email: 'steven@email.com', password: 'secret123')
rand(1..3).times do
  steven.posts.create(title: Faker::Lorem.word, text: Faker::Lorem.sentence)
end

5.times do
  u = User.create(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: 'secretpass123'
  )
  rand(1..3).times do
    u.posts.create(title: Faker::Lorem.word, text: Faker::Lorem.sentence)
  end
end
