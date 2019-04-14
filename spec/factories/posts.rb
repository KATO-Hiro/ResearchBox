FactoryBot.define do
  factory :post do
    sequence(:title) {|n| "Title #{n}"}
    sequence(:author) {"Author"}
    year {Date.today}
    abstract {"Abstract"}
    user
  end
end
