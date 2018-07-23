class CreateTweeps < ActiveRecord::Migration[5.0]
  def change
    create_table :tweeps do |t|
      t.string :query

      t.timestamps
    end
  end
end
