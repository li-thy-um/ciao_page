# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tags = Tag.create([{name: 'ACG'}, {name: 'Ruby'}, {name: 'Python'}, {name: 'C#'}, {name: 'Html'}, {name: 'CSS'}, {name: 'JavaScript'}])
article = Article.create title: 'ACG article', author: 'sw', content: 'this is a ACG article, here is some test content'
article.tags << Tag.find(1)
article.save