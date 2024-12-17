# spec/factories/contacts.rb
FactoryBot.define do
    factory :contact do
      contact_type { ["phone", "whatsapp"].sample }
      value { Faker::PhoneNumber.cell_phone_in_e164}
      association :proponent
    end
  end
  