class Post < ApplicationRecord
  mount_uploaders :figures, FigureUploader
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :stocked_users, through: :stocks, source: :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :author, presence: true
  validates :year, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :abstract, presence: true
end
