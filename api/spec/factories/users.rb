FactoryBot.define do
    factory :user do
      name { "山田 太郎" }
      email { "yamada@example.com" }
      # 他に必要な属性があればここに追加
      password { "password" }
      password_confirmation { "password" }
    end
  end