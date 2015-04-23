class Emergency < ActiveRecord::Base
  attr_accessor :responders_called_off

  validates :code, presence: true, uniqueness: true
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_save :assign_slug
  after_create { ResponderDispatcher.new(self) }
  after_update :call_off_responders, if: :resolved?

  scope :resolved, -> { where(unresolved: 0) }

  has_many :responders

  private

  def assign_slug
    self.slug = code.parameterize
  end

  def call_off_responders
    self.responders = []
    self.responders_called_off = true
    save!
  end

  def resolved?
    !resolved_at.nil? && !responders_called_off
  end
end
