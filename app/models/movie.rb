class Movie < ApplicationRecord

  belongs_to :user
  has_many :favorites
  has_many :comments

  # バリデーション
  validates :team_id, presence: true
  validates :player, presence: true
  validates :day, presence: true
  validates :lyrics, presence: true
  validates :place_id, presence: true
  validates :text, presence: true
  
end
