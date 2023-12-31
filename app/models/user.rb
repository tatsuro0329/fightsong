class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies
  has_many :comments
  has_many :favorites

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def liked?(movie)
    favorites.exists?(movie: movie)
  end

end