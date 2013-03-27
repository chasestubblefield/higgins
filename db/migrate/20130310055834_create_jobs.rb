class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :build
      t.string :status
      t.text :command
      t.text :log
      t.binary :error

      t.timestamps
    end
  end
end
