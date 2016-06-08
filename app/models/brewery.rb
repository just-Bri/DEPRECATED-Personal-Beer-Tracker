class Brewery < ActiveRecord::Base
  has_many :beers

  validates :name, uniqueness: true, :presence => true
end
