FactoryBot.define do
  factory :stock do
    post
    user {post.user}
  end
end
