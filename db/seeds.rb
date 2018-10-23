# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: "user@example.com", password: "password")
Admin.create(email: "admin@example.com", password: "password")
WikiPage.create(title: "Pandas", html: "<p>Pandas are cute.</p>")
WikiPage.create(title: "Rhinos", html: "<p>Rhinos are fierce.</p>")
WikiPage.create(title: "Camels", html: "<p>Camels are useful.</p>")