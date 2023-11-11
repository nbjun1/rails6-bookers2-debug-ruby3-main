class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # メッセージ(DM)関連の記述
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'reciver_id'

  # フォローをした、されたの関係
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使う
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true, presence:true
  validates :introduction, length: { maximum: 50 }


   def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [150, 150]).processed
   end

 #　フォローしたときの処理
 def follow(user_id)
  followers.create(followed_id: user_id)
 end

#　フォローを外すときの処理
 def unfollow(user_id)
  followers.find_by(followed_id: user_id).destroy
 end

#フォローしていればtrueを返す
 def following?(user)
  following_users.include?(user)
 end

 #　検索方法分岐
 def self.looks(search, word)
  if search == "perfect_match"
   @user = User.where("name LIKE?", "#{word}")
  elsif search == "forward_match"
   @user = User.where("name LIKE?", "#{word}%")
  elsif search == "backward_match"
   @user = User.where("name LIKE?", "%#{word}")
  elsif search == "partial_match"
   @user = User.where("name LIKE?", "%#{word}%")
  else
   @user = User.all
  end
 end
end