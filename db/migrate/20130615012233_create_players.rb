class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string :name
      t.integer :facebook_id
      t.integer :sector_id
      t.integer :race_id
      t.timestamps
    end

    create_table :races do |t|
      t.string :name      
    end

    Race.create(name: "Alskant")
    Race.create(name: "Creonti")
    Race.create(name: "Human")
    Race.create(name: "Ik'Thorne")
    Race.create(name: "Nijarin")
    Race.create(name: "Salvene")
    Race.create(name: "Thevian")
    Race.create(name: "WQ Human")
  end

  def down
    drop_table :players
    drop_table :races
  end
end
