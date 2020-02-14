# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{  name: 'Star Wars' }, {  name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ingredients = Ingredient.create!([{ name: 'Lemon' }, { name: 'Apple' }, { name: 'Vodka' }, { name: 'Gin' }, { name: 'Beer' }, { name: 'Lemon' }, { name: 'Lemon' }])
# cocktails = Cocktail.create!([{ name: 'Sex on the beach' }, { name: 'Martini' }, { name: 'Margarita' }, { name: 'Mojito' }, { name: 'Gin Tonic' }])
# Dose.create!({description: '3cl', cocktail_id: cocktails[0], ingredient_id: ingredients[0]})
# Dose.create!({description: '6cl', cocktail_id: cocktails[1], ingredient_id: ingredients[2]})
# Dose.create!({description: '9cl', cocktail_id: cocktails[2], ingredient_id: ingredients[1]})
# Dose.create!({description: '10cl', cocktail_id: cocktails[3], ingredient_id: ingredients[1]})
require 'open-uri'
require 'json'
require 'faker'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

ingredients_list = []

puts "clean ingredient table ...."
puts "......"
Ingredient.destroy_all
  ingredients['drinks'].each do |ingredient|
    ingredients_list << Ingredient.create!(name: ingredient['strIngredient1'])
  end
  puts "#{Ingredient.count} ingredient have been created"
puts "clean ingredient table ...."
Cocktail.destroy_all

cocktails = []
10.times do
  name = Faker::Coffee.blend_name
  cocktails << Cocktail.create!(name: name)
end
puts "#{Cocktail.count} cocktails have been created"

Dose.create!({ description: "2cl", cocktail_id: cocktails[1].id, ingredient_id: ingredients_list[1].id })
Dose.create!({ description: "3cl", cocktail_id: cocktails[2].id, ingredient_id: ingredients_list[2].id })
Dose.create!({ description: "4cl", cocktail_id: cocktails[3].id, ingredient_id: ingredients_list[2].id })
Dose.create!({ description: "1cl", cocktail_id: cocktails[1].id, ingredient_id: ingredients_list[3].id })
Dose.create!({ description: "6cl", cocktail_id: cocktails[2].id, ingredient_id: ingredients_list[1].id })

