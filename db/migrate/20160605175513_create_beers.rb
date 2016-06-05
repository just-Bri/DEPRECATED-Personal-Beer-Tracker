class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.belongs_to :brewery, index: true
      t.belongs_to :user, index: true
      t.string :name
      t.string :style
      t.integer :score
    end
  end
end
