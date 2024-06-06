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

require "faker"

# Défini la langue en Français
Faker::Config.locale = 'fr'

# Destroying everything !!
User.destroy_all
City.destroy_all
Mission.destroy_all
Category.destroy_all

# Admin creation

admin = User.create!(
  first_name: "admin",
  last_name: "admin",
  email: "admin@admin.com",
  phone_number: "0677889911",
  birthdate: Faker::Date.birthday,
  password: '123456',
  password_confirmation: '123456',
  is_admin: true, # Add admin status
  is_host: true,
  is_owner: true,
  is_available: "Indisponible",
  commission: 20
  )

# USERS

disponibilité = ["Disponible", "Indisponible", "Débordé"]

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85),
    password: '123456',
    password_confirmation: '123456',
    is_admin: Faker::Boolean.boolean, # Add admin status
    is_host: true,
    is_owner: false,
    is_available: disponibilité.sample,
    description: Faker::Lorem.paragraph
  )
end

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85),
    password: '123456',
    password_confirmation: '123456',
    is_admin: Faker::Boolean.boolean, # Add admin status
    is_host: true,
    is_owner: true,
    is_available: disponibilité.sample,
    description: Faker::Lorem.paragraph
  )
end

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85),
    password: '123456',
    password_confirmation: '123456',
    is_admin: Faker::Boolean.boolean, # Add admin status
    is_host: false,
    is_owner: true,
    is_available: nil
  )
end

# CITIES

x = 75000
20.times do
  City.create(
    name: "Paris",
    postal_code: x += 1
  )
end

# MISSIONS


status = ["Crée", "Acceptée", "Refusée", "En cours"]
postal_code = ["75001","75002","75003","75004","75005","75006","75007","75008","75009","75010","75011","75012","75013","75014","75016","75016","75017","75018","75019","75020"]

20.times do
  Mission.create(
    title: "Mission #{rand(1..40)}",
    description:  Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: 2.days.ago, to: 15.days.from_now), #=> #<Date: 2014-09-24>
    end_date: Faker::Date.between(from: 15.days.from_now, to: 60.days.from_now),
    status: status.sample,
    city_id: 1,
    host_id: rand(1..20),
    owner_id: rand(11..30),
    postal_code: postal_code.sample
  )
end


# CATEGORIES

Category.create(name:"Remise des clés")
Category.create(name:"Ménage")
Category.create(name:"Shooting photo")
Category.create(name:"Gestion de l'annonce")
Category.create(name:"Mise en ligne de l'annonce")
Category.create(name:"Accueil des voyageurs")
Category.create(name:"Bôite à clés")
Category.create(name:"Départ des voyageurs")
Category.create(name:"Etat des lieux")
Category.create(name:"Fourniture des draps")


puts "Seed successful ! "
