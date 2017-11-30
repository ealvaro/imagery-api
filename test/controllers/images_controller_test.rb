require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = images(:one)
    @tag1 = tags(:one)
    @tag2 = tags(:two)
  end

  test "should get index" do
    get images_url, as: :json
    assert_response :success
  end

  test "should create image" do
    assert_difference('Image.count') do
      post images_url, params: { image: { height: @image.height, name: @image.name, url: @image.url, width: @image.width, tags: [{name: @tag1.name},{name: @tag2.name}] } }, as: :json
    end

    assert_response 201
  end

  test "should show image" do
    get image_url(@image), as: :json
    assert_response :success
  end

  test "should update image" do
    patch image_url(@image), params: { image: { height: @image.height, name: @image.name, url: @image.url, width: @image.width } }, as: :json
    assert_response 200
  end

  test "should destroy image" do
    assert_difference('Image.count', -1) do
      delete image_url(@image), as: :json
    end

    assert_response 204
  end

  test "should search for images" do
    post '/images/search', params: { search_str: @tag1.name }, as: :json
    assert_response 200
  end

end
