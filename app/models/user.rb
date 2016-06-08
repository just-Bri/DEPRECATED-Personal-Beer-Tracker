class User < ActiveRecord::Base
  validates :username, uniqueness: true, :presence => { :message => "Username cannot be blank" }
  validates :email, uniqueness: true, :presence => { :message => "Email cannot be blank" }
  validates :password, :presence => { :message => "Password cannot be blank" }

  has_many  :beers

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
