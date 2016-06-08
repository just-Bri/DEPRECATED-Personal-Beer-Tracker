class User < ActiveRecord::Base
  validates :username, uniqueness: true, :presence => true
  validates :email, uniqueness: true, :presence => true
  validates :password, :presence => true

  has_many  :beers

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
