class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name, null: false
      t.string :ref, null: false
      t.string :status, null: false
      t.binary :error

      t.timestamps
    end
  end
end
