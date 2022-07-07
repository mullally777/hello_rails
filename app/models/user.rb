class User < ApplicationRecord
  has_many :microposts
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :age, presence: true, uniqueness: { case_sensitive: false }
end
