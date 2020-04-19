# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


first_user = FactoryBot.create(:user, username: 'guillaume')

FactoryBot.create_list(:user, 20)

users = User.where.not(username: first_user.username)

users.each { |user| user.send_friend_request(first_user) }

User.all.each { |user| FactoryBot.create_list(:post, 3, user: user) }

FactoryBot.create(:user, username: 'gwen')
