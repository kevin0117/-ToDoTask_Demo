class Tag < ApplicationRecord
  has_many :taggings
  has_many :tasks, through: :taggings
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 15}
  # validates_uniqueness_of :name
  
end
