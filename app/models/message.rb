class Message < ApplicationRecord
  belongs_to :user

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates :message, presence:true

end
