# frozen_string_literal: true

class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at

  belongs_to :user
end
