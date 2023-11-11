class Message < ApplicationRecord
  belongs_to :user

  belongs_to :sender, class_name: 'User'
  belongs_to :reciver, class_name: 'User'
  validates :message, presence:true

end
