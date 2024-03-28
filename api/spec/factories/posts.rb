FactoryBot.define do
    factory :post do
      title { "テストタイトル" }
      content { "rspecでテストをします" }
      user
      # 他に必要な属性があればここに追加
    end
  end