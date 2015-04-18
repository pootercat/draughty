class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :tname
      t.string :division
      t.timestamps
    end
  end
end
