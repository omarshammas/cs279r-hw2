class Button < ActiveRecord::Base
  attr_accessible :name, :parent, :abr, :img

  scope :home, where(parent: :home)
  scope :review, where(parent: :review)
  scope :layout, where(parent: :layout)
  scope :insert, where(parent: :insert)
  scope :view, where(parent: :view)
end
