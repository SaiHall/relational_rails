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
@banana_pud = @flapjack.dishes.create!(name: "Banana Pudding", in_season: false, cost: 5)
