class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :accomplishments

  def accomplish! habit, date
    return if accomplishments_for(habit, date).count > 0
    acc = Accomplishment.new
    acc.user = self
    acc.habit = habit
    acc.date = date
    acc.save!
  end

  def unaccomplish! habit, date
    accomplishments_for(habit, date).map &:delete
  end

  def accomplished? habit, date
    accomplishments_for(habit, date).count > 0
  end

  private
  def accomplishments_for habit, date
    accomplishments.where(
      date: habit.period_range(date),
      habit_id: habit.id
    )
  end
end
