require "application_system_test_case"

class UserDetailsTest < ApplicationSystemTestCase
  setup do
    @user_detail = user_details(:one)
  end

  test "visiting the index" do
    visit user_details_url
    assert_selector "h1", text: "User Details"
  end

  test "creating a User detail" do
    visit user_details_url
    click_on "New User Detail"

    fill_in "Age", with: @user_detail.age
    fill_in "User", with: @user_detail.user_id
    click_on "Create User detail"

    assert_text "User detail was successfully created"
    click_on "Back"
  end

  test "updating a User detail" do
    visit user_details_url
    click_on "Edit", match: :first

    fill_in "Age", with: @user_detail.age
    fill_in "User", with: @user_detail.user_id
    click_on "Update User detail"

    assert_text "User detail was successfully updated"
    click_on "Back"
  end

  test "destroying a User detail" do
    visit user_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User detail was successfully destroyed"
  end
end
