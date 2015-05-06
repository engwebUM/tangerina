# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Theme.create([{name: 'Informatica'}, {name: 'Matematica'}, {name: 'Ciencias'}])
user = User.create! :username => 'ADMIN', :email => 'admin@admin.com', :password => 'admin', :user_type => 1