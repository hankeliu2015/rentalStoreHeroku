# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#  Rental.create(start_date: 01/01/2020, return_date: 02/01/2020, return: false, user_id: 1, tool_id: 1)
# # #
#  Rental.create(start_date: 2020_01_01, return_date: 2020_02_01, return: false, user_id: 2, tool_id: 2)

Tool.create(name: "Floor Polisher", category: "Floor Buffers and Sanders", brand: "Clarke American", description: "For indoor floor only", condition: "fair", image: "floor-polisher.jpg", rental_price: 65)
Tool.create(name: "Wet Vacuum", category: "Vaccums" , brand: "Karcher", description: "Only for water under room temperature", condition: "good", image: "wet-vacuum.jpg", rental_price: 35)

Tool.create(name: "Drum Floor Sander", category: "Floor Buffers and Sanders", brand: "Clarke American", description: "ideal for refinishing old or distressed flooring", condition: "good", image: "drum-floor-sander.jpg", rental_price: 75)
Tool.create(name: "Dry Wall Dust Vacuum", category: "Vaccums" , brand: "Makita", description: "Pair with many dust generating tools to effectively collect airborne particles", condition: "good", image: "drywall-dust-vacuum.jpg", rental_price: 25)

Tool.create(name: "Cordless Paint Sprayer", category: "Parin Sprayer", brand: "Graco", description: "1-gallon & smaller painting jobs", condition: "good", image: "cordless-paint-sprayer.jpg", rental_price: 35)

Tool.create(name: "Inverter Generator", category: "Power Generator" , brand: "Honda", description: "Super quiet, lightweight & fuel efficient", condition: "good", image: "inverter-generator.jpg", rental_price: 25)

Tool.create(name: "Jamb Saw", category: "Saws", brand: "Jet", description: "Easily cuts door jambs, molding & undercuts doors", condition: "fair", image: "jab-saw.jpg", rental_price: 30)

Tool.create(name: "Pallet Jack", category: "Moving Equipment" , brand: "Jet", description: "heavy duty lifting of bulk quantities of material ", condition: "brand new", image: "pallet-jack.jpg", rental_price: 20)
