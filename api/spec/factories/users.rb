FactoryBot.define do
    factory :user do
      name { "山田 太郎" }
      email { "yamada@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end
  end