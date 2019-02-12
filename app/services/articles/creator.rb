# frozen_string_literal: true
# Extract this part of logic to a service class, then it can be reusable. If new logic or requirements come in,
# no need to modify the controller which should be focus on business logic. Just modify this service class.

module Articles
  class Creator
    attr_accessor :article_attrs

    def initialize(article_attrs)
      @article_attrs = article_attrs
    end

    def perform
      ActiveRecord::Base.transaction do
        Article.create!(article_attrs)
      end
    end
  end
end
