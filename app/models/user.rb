class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  has_many :posts, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :stocked_posts, through: :stocks, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  validates :name, presence: true, length: {maximum: 50}

  #投稿がストックされているか判定
  def already_stocked?(post)
    self.stocks.exists?(post_id: post.id)
  end
end
