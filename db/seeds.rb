# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: 'ADMIN', email: 'admin@admin.com', password: 'admin', admin: true)

Theme.create([{name: 'Informatica', image: File.new("#{Rails.root}/app/assets/images/Informatica.png")},
            {name: 'Matematica', image: File.new("#{Rails.root}/app/assets/images/Matematica.png")},
            {name: 'Ciencias', image: File.new("#{Rails.root}/app/assets/images/Ciencias.png")}])
