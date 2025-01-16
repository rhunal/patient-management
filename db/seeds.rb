# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.find_by(email: 'demo@provider.com') || User.create(
  email: 'demo@provider.com',
  password: 'password',
  first_name: 'Demo',
  last_name: 'Provider'
)

first_names = ['John', 'Jane', 'Alice', 'Bob', 'Charlie']
last_names = ['Doe', 'Smith', 'Johnson', 'Williams', 'Brown']
base_emails = ['john', 'jane', 'alice', 'bob', 'charlie']

10.times do |n|
  Patient.create(
    first_name: first_names.sample,
    last_name: last_names.sample,
    email: "#{base_emails.sample}#{n}@example.com"
  )
end
