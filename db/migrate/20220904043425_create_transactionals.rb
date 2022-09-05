class CreateTransactionals < ActiveRecord::Migration[7.0]
  def change
    create_table :transactionals do |t|
      t.datetime :date
      t.json :details
      t.string :type
      t.belongs_to :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
