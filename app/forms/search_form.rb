# class SearchForm
#   include ActiveModel::Model

#   attr_accessor :team_id, :player, :lyrics, :stadium_id

#   def search
#     movies = Movie.all

#     movies = movies.where(team_id: team_id) if team_id.present?
#     movies = movies.where("player LIKE ?", "%#{player}%") if player.present?
#     movies = movies.where("lyrics LIKE ?", "%#{lyrics}%") if lyrics.present?
#     movies = movies.where(stadium_id: stadium_id) if stadium_id.present?

#     movies
#   end
# end