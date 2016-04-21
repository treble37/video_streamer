require 'rails_helper'

describe "VideoPages" do
  before do
    @user = FactoryGirl.create(:user)
    @videos = FactoryGirl.create_list(:video, 6, user: @user)
  end

  it "user navigates to watch a video" do
    visit user_video_path(@user, @videos.first)
    expect(page).to have_content "File Name: nature_clip.mp4"
    expect(page).to have_content "Content Type: video/mp4"
    expect(page).to have_content "File Size: 1065903"
  end

  it "user edits video information" do
    visit edit_user_video_path(@user, @videos.second)
    fill_in "video_title", with: "Star Wars: Phantom Menace"
    fill_in "video_description", with: "Please don't watch this"
    click_button "Save"
  end

  it "user deletes video" do

  end

  it "user uploads new video" do

  end
end
