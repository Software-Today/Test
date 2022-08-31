# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  self.per_page = 10
end
