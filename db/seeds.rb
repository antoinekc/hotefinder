require "faker"
require "open-uri"
require "aws-sdk-s3"

# AWS Credentials
s3_client = Aws::S3::Client.new(
  region: 'eu-west-3',
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
)

s3_resource = Aws::S3::Resource.new(client: s3_client)
bucket = s3_resource.bucket('hote-finder-media')

# Set the locale to French
Faker::Config.locale = 'fr'

# Destroying everything !!
User.destroy_all
City.destroy_all
Mission.destroy_all
Category.destroy_all

puts "all tables seeded"

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
].map { |name| Category.create!(name: name) }

puts "categories seeded"

# CITIES
x = 75000
20.times do
  City.create!(
    name: "Paris",
    postal_code: x += 1
  )
end

puts "cities seeded"

# USERS
disponibilité = ["Disponible", "Indisponible"]
cities = City.all

def create_user(first_name, last_name, email, description, avatar_filename)
  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    phone_number: Faker::PhoneNumber.phone_number,
    birthdate: Faker::Date.birthday(min_age: 25, max_age: 35),
    password: '123456',
    password_confirmation: '123456',
    is_admin: false,
    is_host: true,
    is_owner: false,
    is_available: disponibilité.sample,
    description: description,
    commission: rand(15..30)
  )

  # S3 avatars
  avatar_object = bucket.object(avatar_filename)
  avatar_url = avatar_object.presigned_url(:get, expires_in: 3600)

  avatar_file = URI.open(avatar_url)

  # Determine content type based on file extension
  content_type = case File.extname(avatar_file.path)
                 when '.jpg', '.jpeg' then 'image/jpeg'
                 when '.png' then 'image/png'
                 when '.webp' then 'image/webp'
                 else 'application/octet-stream' # default content type if unknown
                 end

  user.avatar.attach(io: avatar_file, filename: avatar_filename, content_type: content_type)

  # Assign random categories to the user
  user.categories << categories.sample(rand(4..10))

  # Assign random cities to the user
  user.cities << cities.sample(rand(1..3))
end

create_user("Emily", "Dupont", "e@dupont.com", "Emily, je travaille la journee comme tradeuse middle office au siege de la socite generale a la defense et la nuit je me transforme en super host? Pourquoi se donner tant de mal me dire-vous? Pour atteindre la liberte financiere avant 40 ans et ne plus rien faire ensuite", "Emily_Dupont.webp")
create_user("Kevin", "Lochet", "k@lochet.com", "Disponible sur tous les arrondissements de la capitale et de navarre, je travaille comme conceierge a mi-temps afin de pouvoir me payer les dernieres jantes 198 pouces retro rotatives pour ma Xantia", "Kevin_Lochet.webp")
create_user("Sophie", "Craisson", "s@craisson.com", "mon moto de vie: live, love laugh... et je souhaitre le transmettre autour de moi le plus possible. Disponible dans Paris 1 - 7, je travaille en journee comme editrice de set de table IKEA et transmets mon amour, carpe diem", "Sophie_Craisson.webp")
create_user("Jon", "Livremont", "j@livrement.com", "Etudiant en double displome HEC & Polytechnique, ancien champion d'Isere de flechettes, j'aime la performance. Mon objectif a court terme, devenir le plus grand concierge de Paris et le premier influenceur dans le domaine, sky is la limite", "Jon_Livremont.webp")
create_user("Anna", "Maloue", "a@maloue.com", "Depuis le covid, je me suis lance dans le business de la gestion d'appartement a la location dans le 9/10/11eme arrondissement. Mon objectif: me faire le plus d'argent possible sur le dos de la startup nation en visant les logements autours des bureaux de toutes les boites parisiennes les plus en vue du moment #lifehack", "Anna_Maloue.webp")
create_user("Erica", "Linard", "e@linard.com", "I love tourisme you know y tambem encontrar pessosas nuevas y beber cervezas. Oui, je suis une passionnee de langue (duolingo n'a plus de secret pour moi). Pour moi Hote Finder c'est avant tout la possibilite d'echanger avec des gens de partout dans le monde #worldcitizen", "Erica_Linard.webp")
create_user("Lea", "Lagollec", "l@lagollec.com", "A la recherche du plus beau bien immobilier de Paris, j'utillise Hotefinder pour completer mes revenus et faire une etude comparative de tous les Franxprix de la capitale.", "Lea_Lagollec.webp")
create_user("Enrique", "Limoncelle",  "e@limoncelle.com", "6ft5, blue eyes, work in finance. Investisseur en crypto (#marchebullique) et amateur de podcasts et de #personnalgrowth, je suis ouvert aux locations dans le 16eme et sa proche banlieue (Pas au dela de Javel par contre).", "Enrique_Limoncelle.webp")
create_user("Ben", "Jolowitz", "b@jolowitz.com", "Etudiant en Sciences politiques et journalisme, j'utilise HoteFinder essentellement pour me donner des informations pour ecrire mon memoire de fin de master (malin) tout en arrondissant mes fins de mois. Une fois ce dernier en poche je compte sortir un article sur l'impact negatif du marche de l'immobilier locatif sur les habitants de Paris.", "Ben_Jolowitz.webp")
create_user("Olivia", "De Ligonne", "o@deligonne.com", "Apres plusieurs annees sur la route a voyager en europe et au 4 coins du monde avec ma famille, j'ai decide de m'installer a Paris pour renouer avec mon pays et profiter de cet ete pour assister aux JO et financer le tout en travaillant partiellement sur Hote Findus", "Olivia_De_Ligone.webp")

puts "hosts seeded"

# MISSIONS
status = ["Crée", "Acceptée", "Refusée", "En cours"]
postal_code = ["75001", "75002", "75003", "75004", "75005", "75006", "75007", "75008", "75009", "75010", "75011", "75012", "75013", "75014", "75016", "75016", "75017", "75018", "75019", "75020"]

20.times do
  mission = Mission.create!(
    title: "Mission #{rand(1..40)}",
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: 2.days.ago, to: 15.days.from_now),
    end_date: Faker::Date.between(from: 15.days.from_now, to: 60.days.from_now),
    status: status.sample,
    city_id: cities.sample.id,
    host_id: User.where(is_host: true).sample.id,
    owner_id: User.where(is_owner: false).sample.id,
    postal_code: postal_code.sample
  )

  mission.categories << categories.sample(rand(1..3))
end

puts "missions seeded"

puts "Seed successful!"
