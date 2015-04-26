class Emergency < ActiveRecord::Base
  attr_accessor :do_not_call_off

  validates :code, presence: true, uniqueness: true
  validates :medical_severity, :fire_severity, :police_severity,
            presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create { ResponderDispatcher.new(self) }
  after_update :call_off_responders, if: :resolved?

  scope :resolved, -> { where(fire_severity: 0, medical_severity: 0, police_severity: 0) }

  has_many :responders

  # total current severity
  def severity
    fire_severity + medical_severity + police_severity
  end

  private

  # Removes assosiation for all Responders assigned to this emergency
  def call_off_responders
    self.responders = []
    self.do_not_call_off = true
    save!
  end

  # The emergency is resolved if resolved_at isn't nil and responders weren't just called of
  def resolved?
    !resolved_at.nil? && !do_not_call_off
  end
end
