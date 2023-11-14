FactoryBot.define do
  factory :user, class: User do

    sequence(:email) { |n| "ngghai#{n}@gmail.com" }
    password { '123456'}
    first_name { 'John' }
    last_name { 'Cena'}

    trait :invalid do
      email { '' }
      password { ''}
    end
  end
end
