FactoryBot.define do
  factory :comment do
    content { "Content for Comment" }
    post
    user
  end
end
