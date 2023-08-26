class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.integer    :team_id  , null: false
      t.string     :player   , null: false
      t.date       :day      , null: false
      t.string     :lyrics   , null: false
      t.integer    :place_id , null: false
      t.text       :text     , null: false
      t.references :user     , foreign_key: true, null: false
      t.timestamps
    end
  end
end
