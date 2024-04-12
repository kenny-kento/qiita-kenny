FactoryBot.define do
    factory :user do
      name { "山田 太郎" }
      email { "yamada@example.com" }
      password { "password" }
      password_confirmation { "password" }
      confirmation_token { "_wCQHqBrkthWiZ_FUznF" }
      confirmed_at { Date.today }
      confirmation_sent_at { Date.today }
    end
  end