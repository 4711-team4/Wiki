# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "user@example.com", username: "testuser", password: "password")
User.create(email: "admin@example.com", username: "testadmin", password: "password", admin: true)
WikiPage.create(title: "Pandas", content: "<p>Pandas are cute.</p>")
WikiPage.create(title: "Rhinos", content: "<p>Rhinos are fierce.</p>")
WikiPage.create(title: "Camels", content: "<p>Camels are useful.</p>")
Wiki