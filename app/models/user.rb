# frozen_string_literal: true

class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  include UserConcern
end
