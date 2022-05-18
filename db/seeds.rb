# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Dish.destroy_all
Restaurant.destroy_all

@billy = Restaurant.create!(name: "Billy's BBQ Bodega", open: true, guest_capacity: 35)
@flapjack = Restaurant.create!(name: "Flapjack's", open: true, guest_capacity: 105)

@fry_pickle = @billy.dishes.create!(name: "Fried Pickles", in_season: true, cost: 8)
@salad = @billy.dishes.create!(name: "Sensational Steak Salad", in_season: true, cost: 12)
@toast = @billy.dishes.create!(name: "Texas-style Toast", in_season: false, cost: 6)
@ribs = @billy.dishes.create!(name: "Ribs - Bone-in", in_season: true, cost: 17)

@banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: true, cost: 5)
@sunrise = @flapjack.dishes.create!(name: "Sunrise Cider-cakes", in_season: true, cost: 15)
@pancake = @flapjack.dishes.create!(name: "Princess Peach Pancake Pucker", in_season: true, cost: 11)
@melon = @flapjack.dishes.create!(name: "Mouth-watering Mound of Melon", in_season: false, cost: 9)
