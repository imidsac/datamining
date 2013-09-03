class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :datastore, index: true
      t.hstore :data

      t.timestamps
    end
  end
end
