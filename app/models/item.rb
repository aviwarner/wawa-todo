class Item < ApplicationRecord
  belongs_to :list

  validates :text, :list, presence: true
end
