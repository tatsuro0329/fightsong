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
    movies = Movie.all
    movies = movies.where_team(params[:team_id]) if params[:team_id].present?
    movies = movies.where_stadium(params[:stadium_id]) if params[:stadium_id].present?
    movies = movies.where_like(:player, params[:player]) if params[:player].present?
    movies = movies.where_like(:lyrics, params[:lyrics]) if params[:lyrics].present?
    movies
  end

  def self.where_team(team_id)
    where_condition(team_id, :team_id)
  end

  def self.where_stadium(stadium_id)
    where_condition(stadium_id, :stadium_id)
  end

  def self.where_like(attribute, value)
    where("#{attribute} LIKE ?", "%#{value}%")
  end

  def self.where_condition(value, column)
    where(column => value.to_i != 1 ? value : nil)
  end

  def embedded_video_code
    # 埋め込みコードを保存しているフィールド（embedded_video_code）を返す
    self[:embedded_video_code]
  end
  
end