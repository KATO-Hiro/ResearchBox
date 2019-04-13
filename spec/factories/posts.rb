FactoryBot.define do
  factory :post do
    title { "MyString" }
    author { "MyString" }
    year { "2019-04-12" }
    user { nil }
  end
end
