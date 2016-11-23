require 'test_helper'

class SeosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get google_page_index" do
    get :google_page_index
    assert_response :success
  end

  test "should get google_page_rank" do
    get :google_page_rank
    assert_response :success
  end

  test "should get google_page_rank_keywords" do
    get :google_page_rank_keywords
    assert_response :success
  end

  test "should get yahoo_page_index" do
    get :yahoo_page_index
    assert_response :success
  end

  test "should get bing_page_index" do
    get :bing_page_index
    assert_response :success
  end

  test "should get facebook_post" do
    get :facebook_post
    assert_response :success
  end

  test "should get facebook_likes" do
    get :facebook_likes
    assert_response :success
  end

  test "should get facebook_comments" do
    get :facebook_comments
    assert_response :success
  end

  test "should get facebook_shares" do
    get :facebook_shares
    assert_response :success
  end

  test "should get twitter_twitts" do
    get :twitter_twitts
    assert_response :success
  end

  test "should get twitter_follower" do
    get :twitter_follower
    assert_response :success
  end

  test "should get twitter_following" do
    get :twitter_following
    assert_response :success
  end

end
