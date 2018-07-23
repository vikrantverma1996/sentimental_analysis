require 'test_helper'

class TweepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tweep = tweeps(:one)
  end

  test "should get index" do
    get tweeps_url
    assert_response :success
  end

  test "should get new" do
    get new_tweep_url
    assert_response :success
  end

  test "should create tweep" do
    assert_difference('Tweep.count') do
      post tweeps_url, params: { tweep: { query: @tweep.query } }
    end

    assert_redirected_to tweep_url(Tweep.last)
  end

  test "should show tweep" do
    get tweep_url(@tweep)
    assert_response :success
  end

  test "should get edit" do
    get edit_tweep_url(@tweep)
    assert_response :success
  end

  test "should update tweep" do
    patch tweep_url(@tweep), params: { tweep: { query: @tweep.query } }
    assert_redirected_to tweep_url(@tweep)
  end

  test "should destroy tweep" do
    assert_difference('Tweep.count', -1) do
      delete tweep_url(@tweep)
    end

    assert_redirected_to tweeps_url
  end
end
