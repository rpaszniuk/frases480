class AccessProfile < ApplicationRecord
  has_many :users
  serialize :permissions, Hash

  enum status: [:active, :deleted]

  validates :name, presence: true

  def can_be_destroyed?
    !users.exists?
  end

  def mark_as_deleted?
    self.status = :deleted
    save(validate: false)
  end

  def can?(permission, group)
    return true if permissions.dig(group.to_s, permission.to_s) == '1'

    false
  end

  def self.dropdown_menu_options
    active.collect { |ap| [ap.name, ap.id] }
  end

  def self.statuses_map
    statuses.map { |v, _k| [I18n.t("models.access_profile.status.#{v}"), v] }
  end
end
