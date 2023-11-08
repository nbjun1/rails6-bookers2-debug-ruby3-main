class Message < ApplicationRecord
  belongs_to :user

  belongs_to :sender, class_name: 'User'
  belongs_to :reciver, class_name: 'User'
  validates :message, presence:true
  def other_user(current_user)
    sender == current_user ? recipient : sender
  end
end
