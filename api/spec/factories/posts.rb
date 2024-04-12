FactoryBot.define do
    factory :post do
      title { "テストタイトル" }
      content { "rspecでテストをします" }
      association :user
    end
  end