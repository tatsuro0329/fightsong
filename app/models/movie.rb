class Movie < ApplicationRecord

  belongs_to :user
  has_many :favorites
  has_many :comments
  has_many :movie_tags
  has_many :tags, through: :movie_tags
  belongs_to_active_hash :team
  belongs_to_active_hash :stadium

  validates :team_id, presence: true
  validates :player, presence: true
  validates :day, presence: true
  validates :lyrics, presence: true
  validates :place_id, presence: true
  validates :text, presence: true
  validates :team_id, :stadium_id, numericality: { other_than: 1, message: "can't be blank" }

end