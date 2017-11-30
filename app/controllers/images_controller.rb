class ImagesController < ApplicationController
  include EndpointHeader
  before_action :set_image, only: [:show, :update, :destroy]

  # POST /search
  def search
    render nothing:true, status:422 and return if params[:search_str].nil? || params[:max_results].nil?
    results = query_by_str(params[:search_str])
    images = results.map { |t| t.images}.flatten.uniq
    render nothing:true, status:422 and return if params[:max_results].to_i < images.size
    imgs_serialized = ActiveModel::Serializer::CollectionSerializer.new(images, each_serializer: ImageSerializer)
    render json: add_header(imgs_serialized),  root: false
  end

  # GET /images
  def index
    @images = Image.all
    img_serializer = ActiveModel::Serializer::CollectionSerializer.new(@images, each_serializer: ImageSerializer)
    render json: add_header(img_serializer),  root: false
  end

  # GET /images/1
  def show
    render json: @image
  end

  # POST /images
  def create
    post_attributes = image_params
    tag_attributes = post_attributes.delete("tags")
    @image = Image.new(post_attributes)
    @image.tags = tag_attributes.map{|t| Tag.find_by(name: t["name"]) || Tag.new(name: t["name"])}

    if @image.save
      render json: @image, status: :created, location: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:name, :width, :height, :url, {:tags => [:name]})
    end

    def query_by_str(search)
      arr = search.split(',')
      all_tags = arr.map { |str| Tag.find_by(name: str)}
      all_tags.uniq
    end

end
