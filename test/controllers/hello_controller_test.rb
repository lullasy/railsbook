require 'test_helper'

class HelloControllerTest < ActionController::TestCase
  test "list action" do
    get :list
    assert_equal 10, assigns(:books).length, 'found rows is wrong.'
    assert_response :success, 'list action failed.'
    assert_template 'hello/list'
  end

  test "routing check" do
    assert_generates('hello/list', {controller: 'hello', action: 'list'})
  end

  test "select check" do
    get :list
    assert_select 'title'
    assert_select 'title', true
    assert_select 'font', false
    assert_select 'title', 'Railbook'
    # FIXME:'true'→/.+/に変えると動かない、なんで？？？？
    assert_select 'script[data-turbolinks-track=?]', 'true'
    assert_select 'table tr', 11
    assert_select 'table' do
      assert_select 'tr', 1..11
    end
    assert_select 'title', {count: 1, text: 'Railbook'}
  end

  # test "the truth" do
  #   assert true
  # end
end
