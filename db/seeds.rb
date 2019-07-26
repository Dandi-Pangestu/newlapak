# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

Product.create!([{
    name: 'Mie Goreng Ayam',
    price: 2000,
    stock: 100
},
{
   name: 'Mie Goreng Sapi',
   price: 20000,
   stock: 100
},
{
   name: 'Mie Goreng Aceh',
   price: 3000,
   stock: 100
},
{
   name: 'Mie Goreng Pedas',
   price: 4000,
   stock: 100
}])

p "Created #{Product.count} products"