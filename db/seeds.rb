require "faker"
require "open-uri"

# Défini la langue en Français
Faker::Config.locale = 'fr'

# Destroying everything !!
User.destroy_all
City.destroy_all
Mission.destroy_all
Category.destroy_all

puts "all tables seeded"

# Admin creation
admin = User.create!(
  first_name: "admin",
  last_name: "admin",
  email: "admin@admin.com",
  phone_number: "0677889911",
  birthdate: Faker::Date.birthday,
  password: '123456',
  password_confirmation: '123456',
  is_admin: true,
  is_host: true,
  is_owner: true,
  is_available: "Indisponible",
  commission: 20
)

puts "admin seeded"

# Create Categories
categories = %w[
  Remise\ des\ clés
  Ménage
  Shooting\ photo
  Gestion\ de\ l'annonce
  Mise\ en\ ligne\ de\ l'annonce
  Accueil\ des\ voyageurs
  Bôite\ à\ clés
  Départ\ des\ voyageurs
  Etat\ des\ lieux
  Fourniture\ des\ draps
].map { |name| Category.create(name: name) }

puts "categories seeded"

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
    is_admin: Faker::Boolean.boolean,
    is_host: true,
    is_owner: false,
    is_available: disponibilité.sample,
    description: Faker::Lorem.paragraph,
    commission: rand(15..30)
  )

  # Local avatars
  avatar_path = Rails.root.join('app/assets/images/avatars', 'portrait_01.jpg')
  avatar_file = File.open(avatar_path)
  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')

  # Assign random categories to the user
  user.categories << categories.sample(rand(1..3))
end

puts "hosts seeded"

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85),
    password: '123456',
    password_confirmation: '123456',
    is_admin: Faker::Boolean.boolean,
    is_host: true,
    is_owner: true,
    is_available: disponibilité.sample,
    description: Faker::Lorem.paragraph,
    commission: rand(15..30)
  )

  # Local avatars
  avatar_path = Rails.root.join('app/assets/images/avatars', 'portrait_02.jpg')
  avatar_file = File.open(avatar_path)
  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')

  # Assign random categories to the user
  user.categories << categories.sample(rand(1..3))
end

puts "host-owners seeded"

10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 18, max_age: 85),
    password: '123456',
    password_confirmation: '123456',
    is_admin: Faker::Boolean.boolean,
    is_host: false,
    is_owner: true,
    is_available: nil,
    commission: rand(15..30)
  )

  # Local avatars
  avatar_path = Rails.root.join('app/assets/images/avatars', 'portrait_02.jpg')
  avatar_file = File.open(avatar_path)
  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')

  # Assign random categories to the user
  user.categories << categories.sample(rand(1..3))
end

puts "owners seeded"

# CITIES
x = 75000
20.times do
  City.create(
    name: "Paris",
    postal_code: x += 1
  )
end

puts "cities seeded"

# MISSIONS
status = ["Crée", "Acceptée", "Refusée", "En cours"]
postal_code = ["75001","75002","75003","75004","75005","75006","75007","75008","75009","75010","75011","75012","75013","75014","75016","75016","75017","75018","75019","75020"]

20.times do
  mission = Mission.create(
    title: "Mission #{rand(1..40)}",
    description:  Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: 2.days.ago, to: 15.days.from_now),
    end_date: Faker::Date.between(from: 15.days.from_now, to: 60.days.from_now),
    status: status.sample,
    city_id: 1,
    host_id: rand(1..20),
    owner_id: rand(11..30),
    postal_code: postal_code.sample
  )

  mission.categories << categories.sample(rand(1..3))
end

puts "missions seeded"

puts "Seed successful!"
