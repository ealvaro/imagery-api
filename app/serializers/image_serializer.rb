class ImageSerializer <   ActiveModel::Serializer
  attributes :url,  :width, :height
  belongs_to :tags
end

