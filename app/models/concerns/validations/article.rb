module Validations::Article
  extend ActiveSupport::Concern
  included do
    validates_presence_of :title, :body, :date
  end
end
