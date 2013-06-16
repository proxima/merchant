class CreateGalaxies < ActiveRecord::Migration
  def up
    create_table :galaxies do |t|
      t.integer :min_sector_id
      t.integer :max_sector_id
      t.integer :dimension
      t.integer :race_id
      t.timestamps
    end

    smallid = 1
    largeid = 100

    Race.find(:all).each do |r|
      Galaxy.create(min_sector_id: smallid, max_sector_id: largeid, dimension: 10, race_id: r.id)
      smallid = smallid + 100
      largeid = largeid + 100
    end
    
  end

  def down
    drop_table :galaxies
  end
end
