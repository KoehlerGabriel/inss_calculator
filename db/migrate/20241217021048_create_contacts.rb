class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :contact_type
      t.string :value
      t.references :proponent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
