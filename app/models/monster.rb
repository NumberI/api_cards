class Monster < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  TYPES = %w(fire water earth electric wind)

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
  validates :power, presence: true
  validates :type, presence: true, inclusion: {in: TYPES}
  validate :more_monsters, on: :create
  validate :team_size

  private

  def team_size
    if team && !team.allows_new_monster?
      errors.add(:base, 'Team size limit exceeded')
    end
  end

  def more_monsters
    unless user.allows_new_monster?
      errors.add(:base, 'Reached the number of monsters')
    end
  end
end
