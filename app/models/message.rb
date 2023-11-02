class Message < ApplicationRecord
  belongs_to :user
  validate :message, presence:true
  def other_user(current_user)
    sender == current_user ? recipient : sender
  end
end
