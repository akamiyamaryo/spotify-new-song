class CreateMusics < ActiveRecord::Migration[7.0]
  def change
    create_table :musics do |t|
      t.string :artist_name
      t.string :track_name
      t.string :link
      t.string :string

      t.timestamps
    end
  end
end
