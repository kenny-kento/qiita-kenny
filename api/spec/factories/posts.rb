FactoryBot.define do
    factory :post do
      title { "テストタイトル" }
      content { "rspecでテストをします" }
      user
    end
  end