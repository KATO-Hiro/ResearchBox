FactoryBot.define do
  factory :comment do
    content { "Content for Comment" }
    post
    user {post.user}
  end
end
