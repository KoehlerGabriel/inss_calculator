class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :birth_date
      t.decimal :salary
      t.decimal :inss_discount

      t.timestamps
    end
  end
end
