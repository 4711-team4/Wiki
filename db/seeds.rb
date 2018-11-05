# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: "user@example.com", username: "testuser", password: "password")
User.create(email: "admin@example.com", username: "testadmin", password: "password", admin: true)
page1 = WikiPage.create(locked: false)
page2 = WikiPage.create(locked: false)
page3 = WikiPage.create(locked: false)
page1.revisions.new(title: "Pandas", content: "<p>Pandas are cute.</p>", user: user).save!
page2.revisions.new(title: "Rhinos", content: "<p>Rhinos are fierce.</p>", user: user).save!
page3.revisions.new(title: "Camels", content: "<p>Camels are useful.</p>", user: user).save!