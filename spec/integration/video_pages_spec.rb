require 'rails_helper'

describe "VideoPages" do
  before do
    @user = FactoryGirl.create(:user)
    @videos = FactoryGirl.create_list(:video, 6, user: @user)
  end

  it "user navigates to watch a video" do
    visit user_video_path(@user, @videos.first)
    expect(page).to have_content "Title1"
    expect(page).to have_content "Description1"
    expect(page).to have_content "Length: 5:00"
  end

  it "user edits video information" do
    video_id = @videos.second.id
    video_title = "Star Wars: Phantom Menace"
    video_desc = "Please don't watch this"
    video_length = "8:05"
    visit edit_user_video_path(@user, id: video_id)
    fill_in "video_title", with: video_title
    fill_in "video_description", with: video_desc
    fill_in "video_length", with: video_length
    click_button "Update Video"
    visit user_video_path(@user, id: video_id)
    expect(page).to have_content video_title
    expect(page).to have_content video_desc
    expect(page).to have_content video_length
  end

  it "user deletes video" do
    visit user_videos_path(@user)
    expect { first(:link, "Destroy").click }.to change(Video, :count).by(-1)
  end
end
