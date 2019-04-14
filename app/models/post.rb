class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :author, presence: true
  validates :year, presence: true
  validates :title, presence: true

end
