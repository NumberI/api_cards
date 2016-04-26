class User < ActiveRecord::Base
  has_many :teams
  has_many :monsters

  ALLOWED_MONSTERS_COUNT = 20
  ALLOWED_TEAMS_COUNT = 3

  def allows_new_monster?
    monsters_count < ALLOWED_MONSTERS_COUNT
  end

  def allows_new_team?
    teams_count < ALLOWED_TEAMS_COUNT
  end

	TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  validates_uniqueness_of :email, scope: :provider

  def self.from_omniauth(auth)
    email = auth.info.email
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
