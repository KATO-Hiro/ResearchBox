class Post < ApplicationRecord
  mount_uploaders :figures, FigureUploader
  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :stocked_users, through: :stocks, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :comment

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :author, presence: true
  validates :year, presence: true
  validates :title, presence: true, length: {maximum: 100}
  validates :abstract, presence: true
end
