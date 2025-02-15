class Party < ApplicationRecord
  validates :host, presence: true
  validates :movie_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :movie_title, presence: true

  belongs_to :host, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :invitees, through: :invitations

  def start_time
    start.strftime('%l:%M %P')
  end

  def date
    start.strftime('%D')
  end
end
