class Category < ApplicationRecord
  has_many :phrases, dependent: :restrict_with_error

  enum status: [:active, :inactive, :deleted]

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }, if: -> { name_changed? }
  validates :slug, uniqueness: { case_sensitive: true }, if: -> { slug_changed? }

  before_validation :set_slug_if_empty
  before_save :clean_stuff

  def title
    name
  end

  protected

  def set_slug_if_empty
    self.slug ||= ActiveSupport::Inflector.transliterate(self.name)
  end

  def clean_stuff
    self.slug = self.slug.parameterize
  end
end
