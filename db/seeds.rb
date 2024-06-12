require "faker"
require "open-uri"
require "aws-sdk-s3"

AWS Credentials
s3_client = Aws::S3::Client.new(
  region: ENV['AWS_REGION'],
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)

s3_resource = Aws::S3::Resource.new(client: s3_client)
bucket = s3_resource.bucket(ENV['AWS_BUCKET'])

# Définir la langue en français
Faker::Config.locale = 'fr'

# Détruire tout !!
User.destroy_all
City.destroy_all
Mission.destroy_all
Category.destroy_all

puts "Toutes les tables ont été initialisées."

# Création de l'administrateur
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

puts "Admin seeded."

# UTILISATEURS
disponibilite = ["Disponible", "Indisponible", "Débordé"]

10.times do
  User.create!(
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
    is_available: disponibilite.sample,
    description: Faker::Lorem.paragraph
  )

  # S3 avatars
  avatar_object = bucket.object('portrait_01.jpg')
  avatar_url = avatar_object.presigned_url(:get, expires_in: 3600)

  avatar_file = URI.open(avatar_url)

  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')
end

puts "Hôtes initialisés."

20.times do
  User.create!(
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
    is_available: disponibilite.sample,
    description: Faker::Lorem.paragraph
  )

  # S3 avatars
  avatar_object = bucket.object('portrait_02.jpg')
  avatar_url = avatar_object.presigned_url(:get, expires_in: 3600)

  avatar_file = URI.open(avatar_url)

  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')
end

puts "Propriétaires d'hôtes initialisés."

2.times do
  User.create!(
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
    is_available: nil
  )

  # S3 avatars
  avatar_object = bucket.object('portrait_02.jpg')
  avatar_url = avatar_object.presigned_url(:get, expires_in: 3600)

  avatar_file = URI.open(avatar_url)

  user.avatar.attach(io: avatar_file, filename: 'avatar.jpg', content_type: 'image/jpg')
end

puts "Propriétaires initialisés."

# VILLES
x = 75000
20.times do
  City.create(
    name: "Paris",
    postal_code: x += 1
  )
end

puts "Villes initialisées."

# MISSIONS
status = ["Créée", "Acceptée", "Refusée", "En cours"]
postal_codes = ["75001","75002","75003","75004","75005","75006","75007","75008","75009","75010","75011","75012","75013","75014","75016","75016","75017","75018","75019","75020"]

20.times do
  Mission.create(
    title: "Mission #{rand(1..40)}",
    description:  Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: 2.days.ago, to: 15.days.from_now),
    end_date: Faker::Date.between(from: 15.days.from_now, to: 60.days.from_now),
    status: status.sample,
    city_id: 1,
    host_id: rand(1..20),
    owner_id: rand(11..30),
    postal_code: postal_codes.sample
  )
end

puts "Missions initialisées."

# CATÉGORIES
Category.create(name:"Remise des clés")
Category.create(name:"Ménage")
Category.create(name:"Shooting photo")
Category.create(name:"Gestion de l'annonce")
Category.create(name:"Mise en ligne de l'annonce")
Category.create(name:"Accueil des voyageurs")
Category.create(name:"Boîte à clés")
Category.create(name:"Départ des voyageurs")
Category.create(name:"État des lieux")
Category.create(name:"Fourniture des draps")

puts "Catégories initialisées."

puts "Initialisation terminée ! "
