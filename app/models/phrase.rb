class Phrase < ApplicationRecord
  belongs_to :category
  belongs_to :user

  enum status: [:active, :pending, :rejected, :deleted]

  validates_presence_of :category, :user
  validates :phrase, presence: true, length: { minimum: 30, maximum: 480 }
  validates :phrase, uniqueness: { case_sensitive: false }, if: -> { phrase_changed? }
  validates :slug, uniqueness: { case_sensitive: true }, if: -> { slug_changed? }

  before_validation :set_slug_if_empty
  before_save :clean_stuff
  after_save :clear_cache, if: -> { active? }

  def title
    "#{category.description}: #{phrase.split(' ').first(10).join(' ')}..."
  end

  def title_for_share
    "Frase de #{category.description}"
  end

  def self.statuses_map
    statuses.map { |v, _k| [I18n.t("models.phrase.status.#{v}"), v] }
  end

  def generate_slug
    ActiveSupport::Inflector.transliterate(self.phrase).gsub(/[^a-zA-Z0-9 ]/, '').split(' ').first(10).join(' ')
  end

  def mark_as_deleted?
    self.status = :deleted
    save(validate: false)
  end

  def can_be_destroyed?
    user.is_super_user?
  end

  protected

  def set_slug_if_empty
    self.slug ||= generate_slug
  end

  def clean_stuff
    self.slug = self.slug.parameterize
    self.phrase.strip!
  end

  def clear_cache
    CacheEngine.wildcard_del('web_phrases_page_*')
    CacheEngine.wildcard_del("web_#{self.category_id}_phrases_page_*")
    CacheEngine.del('web_phrases_count')
    CacheEngine.del("web_#{self.category_id}_phrases_count")
  end
end
