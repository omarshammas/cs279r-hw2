class User < ActiveRecord::Base
  attr_accessible :age, :gender, :input_device, :initial_interface, :code, :browser

  has_many :tasks, dependent: :destroy
  has_many :nasatlx, dependent: :destroy

end
