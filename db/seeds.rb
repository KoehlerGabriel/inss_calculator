
# db/seeds.rb

require "faker"

puts "Inciando seed..."

User.destroy_all
Proponent.destroy_all
Address.destroy_all
Contact.destroy_all

user = User.new(email: "admin@admin.com", password:"admin123", password_confirmation: "admin123")
user.save!

15.times do
  proponent = Proponent.create!(
    name: Faker::Name.name,
    document: Faker::IdNumber.brazilian_citizen_number,
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
    salary: Faker::Number.decimal(l_digits: 4, r_digits: 2),
  )

  Address.create!(
    street: Faker::Address.street_name,
    number: Faker::Address.building_number,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: Faker::Address.zip_code,
    proponent_id: proponent.id
  )

  2.times do
    Contact.create!(
      contact_type: ['Telefone', 'Celular'].sample,
      value: Faker::PhoneNumber.cell_phone_in_e164,
      proponent_id: proponent.id
    )
  end
end

puts "Seed completa!"
