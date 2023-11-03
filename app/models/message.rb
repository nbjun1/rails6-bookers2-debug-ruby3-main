class Message < ApplicationRecord
  belongs_to :user

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validate :message, presence:true
  def other_user(current_user)
    sender == current_user ? recipient : sender
  end
end
