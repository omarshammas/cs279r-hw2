class Task < ActiveRecord::Base
  attr_accessible :block, :button, :bad_clicks, :position, :time, :user_id

  belongs_to :user

  scope :familiar, where(block: 'familiarization')
  scope :performance, where(block: 'performance')
end
