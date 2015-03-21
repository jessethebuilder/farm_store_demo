class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :tax_rate

      t.timestamps null: false
    end
  end
end
