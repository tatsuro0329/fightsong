class Movie < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user
  has_many :comments
  has_many :movie_tags
  has_many :tags, through: :movie_tags
  belongs_to_active_hash :team
  belongs_to_active_hash :stadium

  validates :team_id, presence: true
  validates :player, presence: true
  validates :day, presence: true
  validates :lyrics, presence: true
  validates :stadium_id, presence: true
  validates :team_id, :stadium_id, numericality: { other_than: 1, message: "can't be blank" }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["lyrics", "player", "stadium_id", "team_id"]
  end

  def self.search(params)
    binding.pry
    movies = Movie.all
    
    # team_id が 1 でない場合だけ、team_id での検索を行う
    if params[:team_id].present? && params[:team_id].to_i != 1
      movies = movies.where("team_id = ?", params[:team_id])
    end
  
    # stadium_id が 1 でない場合だけ、stadium_id での検索を行う
    if params[:stadium_id].present? && params[:stadium_id].to_i != 1
      movies = movies.where("stadium_id = ?", params[:stadium_id])
    end
    
    # その他の条件
    movies = movies.where("player LIKE ?", "%#{params[:player]}%") if params[:player].present?
    movies = movies.where("lyrics LIKE ?", "%#{params[:lyrics]}%") if params[:lyrics].present?
    
    movies
  end
  
end