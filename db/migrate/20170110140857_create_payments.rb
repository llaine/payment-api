class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.belongs_to :contract, foreign_key: true
      t.string :description
      t.integer :value
      t.datetime :time
      t.boolean :is_imported
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
