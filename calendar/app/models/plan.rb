class Plan < ActiveRecord::Base
  validates :title, presence: true
  validates :detail, length: { maximum: 200 }
end
