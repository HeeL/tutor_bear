class Language < ActiveRecord::Base
  
  attr_accessible :name

  has_and_belongs_to_many :teachers
  has_and_belongs_to_many :learners

  validates :name, presence: true, uniqueness: true

  translates :name
  
  def self.match_names(name, exact = false)
    name = "%#{name}%" unless exact
    self.with_translations(I18n.locale).where('language_translations.name ILIKE ?', name).all.map(&:name)
  end
  
end