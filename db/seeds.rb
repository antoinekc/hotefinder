# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# <User id: nil, email: "", first_name: nil, last_name: nil, phone_number: nil, birthdate: nil, commission: nil, is_host: nil, is_owner: nil, is_available: nil, is_admin: nil, created_at: nil, updated_at: nil>

require Faker

# Défini la langue en Français
Faker::Config.local = 'fr'

# Destroying everything !!
User.destroy_all
City.destroy_all
Mission.destroy_all

# Admin creation 

admin = User.create!(
  first_name: "admin"
  last_name: "admin",
  email: "admin@admin.com",
  phone_number: "0677889911",
  birthdate: 05-06-1980,
  password: '123456',
  password_confirmation: '123456',
  isadmin: true, # Add admin status
  is_host: true, 
  is_owner: true, 
  is_available: true,
  commission: 20
  )

# USERS

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85)
    password: '123456',
    password_confirmation: '123456',
    isadmin: Faker::Boolean.boolean # Add admin status
    is_host: true,
    is_owner: false,
    is_available: Faker::Boolean.boolean
  )
end

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85)
    password: '123456',
    password_confirmation: '123456',
    isadmin: Faker::Boolean.boolean # Add admin status
    is_host: true,
    is_owner: true,
    is_available: Faker::Boolean.boolean
  )
end

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85)
    password: '123456',
    password_confirmation: '123456',
    isadmin: Faker::Boolean.boolean # Add admin status
    is_host: false,
    is_owner: true,
    is_available: nil
  )
end

# CITIES

Faker::Config.local = 'fr'

x = 75000
20.times do
  City.create(
    name: "Paris",
    postal_code: x += 1
  )
end

# MISSIONS 

status = ["Disponible", "Indisponible", "Débordé"]

20.times do
  Mission.create(
    title: Faker::Lorem.sentence(word_count: 10),
    description:  Faker::Lorem.paragraph, 
    start_date: Faker::Date.between(from: 2.days.ago, to: 15.days.from_now), #=> #<Date: 2014-09-24>
    end_date: Faker::Date.between(from: 15.days.from_now, to: 60.days.from_now),
    status: status.sample,
    host: rand(1..20),
    owner: rand(11..30)
  end
  )

# CATEGORIES

category.create(name:"Remise des clés")
category.create(name:"Ménage")
category.create(name:"Shooting photo")
category.create(name:"Gestion de l'annonce")
category.create(name:"Mise en ligne de l'annonce")
category.create(name:"Accueil des voyageurs")
category.create(name:"Bôite à clés")
category.create(name:"Départ des voyageurs")
category.create(name:"Etat des lieux")
category.create(name:"Fourniture des draps")


end