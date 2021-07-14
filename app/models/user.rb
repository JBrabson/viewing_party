class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :hosted_parties, class_name: 'Party', dependent: :destroy, foreign_key: :host_id
  has_many :invitations, dependent: :destroy, foreign_key: :invitee_id
  has_many :invited_parties, through: :invitations, source: :party
end
