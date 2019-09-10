class AccessProfile < ActiveRecord::Base
  has_many :users
  serialize :permissions

  validates :name, presence: true

  def can?(permission, group)
    (self.permissions[group.to_s][permission.to_s] rescue nil) == '1' ? true : false
  end
end
