require "test_helper"

class MoodDetectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mood_detection = mood_detections(:one)
  end

  test "should get index" do
    get mood_detections_url
    assert_response :success
  end

  test "should get new" do
    get new_mood_detection_url
    assert_response :success
  end

  test "should create mood_detection" do
    assert_difference("MoodDetection.count") do
      post mood_detections_url, params: { mood_detection: { confidence: @mood_detection.confidence, mood: @mood_detection.mood, user_name: @mood_detection.user_name } }
    end

    assert_redirected_to mood_detection_url(MoodDetection.last)
  end

  test "should show mood_detection" do
    get mood_detection_url(@mood_detection)
    assert_response :success
  end

  test "should get edit" do
    get edit_mood_detection_url(@mood_detection)
    assert_response :success
  end

  test "should update mood_detection" do
    patch mood_detection_url(@mood_detection), params: { mood_detection: { confidence: @mood_detection.confidence, mood: @mood_detection.mood, user_name: @mood_detection.user_name } }
    assert_redirected_to mood_detection_url(@mood_detection)
  end

  test "should destroy mood_detection" do
    assert_difference("MoodDetection.count", -1) do
      delete mood_detection_url(@mood_detection)
    end

    assert_redirected_to mood_detections_url
  end
end
