class ArticlesSerializer < ActiveModel::Serializer
  attributes :tag, :count, :articles, :related_tags

  def tag
    instance_options[:tag]
  end

  def count
    # not sure about this one.
    # The count field shows the number of tags for the tag for that day.
    object.map(&:tags).flatten.count
  end

  def articles
    object.first(10).map(&:id)
  end

  def related_tags
    object.map(&:tags).flatten.uniq
  end
end
