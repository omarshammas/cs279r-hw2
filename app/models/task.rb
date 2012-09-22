class Task < ActiveRecord::Base
  attr_accessible :block, :bad_clicks, :position, :time, :user_id, :button_id, :menu

  belongs_to :user 
  belongs_to :button

  scope :familiar, where(block: 'familiarization')
  scope :performance, where(block: 'performance')

end
