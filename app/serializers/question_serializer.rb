# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :tags
  belongs_to :user
  has_many :answers
end
