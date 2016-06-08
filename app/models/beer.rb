class Beer < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :user

  validates :name, :presence => true
  validates :style, :presence => true
  validates :brewery, :presence => true
  validates :score, :presence => true, numericality: { only_integer: true }
end
