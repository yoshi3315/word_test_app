class Question < ApplicationRecord
  with_options presence: true do
    validates :question
    validates :description
  end
end
