class ImageSerializer <   ActiveModel::Serializer
  attributes :url,  :width, :height, :tags

  def tags
    ActiveModel::Serializer::CollectionSerializer.new(object.tags, each_serializer: TagSerializer)
  end

end

