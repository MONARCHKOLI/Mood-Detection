require "application_system_test_case"

class MoodDetectionsTest < ApplicationSystemTestCase
  setup do
    @mood_detection = mood_detections(:one)
  end

  test "visiting the index" do
    visit mood_detections_url
    assert_selector "h1", text: "Mood detections"
  end

  test "should create mood detection" do
    visit mood_detections_url
    click_on "New mood detection"

    fill_in "Confidence", with: @mood_detection.confidence
    fill_in "Mood", with: @mood_detection.mood
    fill_in "User name", with: @mood_detection.user_name
    click_on "Create Mood detection"

    assert_text "Mood detection was successfully created"
    click_on "Back"
  end

  test "should update Mood detection" do
    visit mood_detection_url(@mood_detection)
    click_on "Edit this mood detection", match: :first

    fill_in "Confidence", with: @mood_detection.confidence
    fill_in "Mood", with: @mood_detection.mood
    fill_in "User name", with: @mood_detection.user_name
    click_on "Update Mood detection"

    assert_text "Mood detection was successfully updated"
    click_on "Back"
  end

  test "should destroy Mood detection" do
    visit mood_detection_url(@mood_detection)
    click_on "Destroy this mood detection", match: :first

    assert_text "Mood detection was successfully destroyed"
  end
end
