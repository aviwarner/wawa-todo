class User < ApplicationRecord
  has_many :lists, dependent: :destroy

  validates :email, presence: true, uniqueness: { message: "\"%{value}\" is already in use." }
end
