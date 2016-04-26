class Team < ActiveRecord::Base
  has_many :monsters
  belongs_to :user

  ALLOWED_MONSTERS_COUNT = 3

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validate :available_teams, on: :create

  def allows_new_monster?
    monsters_count < ALLOWED_MONSTERS_COUNT
  end

  private
  def available_teams
    unless user.allows_new_team?
      errors.add(:base, 'Reached maximum number of teams')
    end
  end
end
