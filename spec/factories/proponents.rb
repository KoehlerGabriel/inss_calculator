# spec/factories/proponents.rb
FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    document { Faker::IdNumber.valid }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { nil }  # Inicializando como nil, para testar o cálculo
  end
end
