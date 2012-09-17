class User < ActiveRecord::Base
  attr_accessible :ip, :turk_id

  has_many :tasks, dependent: :destroy

  #need to serialize the ip because the request can return a list of ip addresses some times
  serialize :ip
end
