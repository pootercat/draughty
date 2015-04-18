class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :team
      t.references :player
      t.integer :round
      t.integer :pick
      t.timestamps
    end
  end
end
