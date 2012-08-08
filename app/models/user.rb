class User < ActiveRecord::Base
  acts_as_authentic

  before_create :default_chore_date
  def default_chore_date
    self.chore_date = 1.days.ago
  end

  def self.current_chore_user
    u = User.find_by_chore_date(Time.now.to_date)
    if !u
      u = User.order('chore_date ASC').first
      u.update_attribute(:chore_date, Time.now.to_date)
    end
    u
  end
end
