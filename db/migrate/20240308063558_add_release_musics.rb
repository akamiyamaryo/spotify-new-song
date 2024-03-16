class AddReleaseMusics < ActiveRecord::Migration[7.0]
  def change
    add_column :musics, :release_date, :string
  end
end
