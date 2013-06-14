class CreateSectorsAndExits < ActiveRecord::Migration
  def up
    create_table :sectors do |t|
      t.timestamps
    end

    create_table :exits do |t|
      t.integer :cost
      t.integer :source
      t.integer :destination
      t.integer :direction
      t.timestamps
    end
  end

  def down
    drop_table :sectors
    drop_table :exits
  end
end
