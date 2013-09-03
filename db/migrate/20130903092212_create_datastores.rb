class CreateDatastores < ActiveRecord::Migration
  def change
    create_table :datastores do |t|
      t.string :path

      t.timestamps
    end
  end
end
