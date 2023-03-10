class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :assigned_tasks, through: :assignments, source: :task

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

  def all_tasks
    (tasks.all + assigned_tasks.all).uniq
  end
end
