require "application_system_test_case"

class AnimalsTest < ApplicationSystemTestCase
  setup do
    @animal = animals(:one)
  end

  test "visiting the index" do
    visit animals_url
    assert_selector "h1", text: "Animals"
  end

  test "creating a Animal" do
    visit animals_url
    click_on "New Animal"

    fill_in "Cites", with: @animal.cites_id
    fill_in "Class", with: @animal.animal_class
    fill_in "Common Name", with: @animal.common_name
    fill_in "Family", with: @animal.family
    fill_in "Kingdom", with: @animal.kingdom
    fill_in "Order", with: @animal.order
    fill_in "Phylum", with: @animal.phylum
    click_on "Create Animal"

    assert_text "Animal was successfully created"
    click_on "Back"
  end

  test "updating a Animal" do
    visit animals_url
    click_on "Edit", match: :first

    fill_in "Cites", with: @animal.cites_id
    fill_in "Class", with: @animal.animal_class
    fill_in "Common Name", with: @animal.common_name
    fill_in "Family", with: @animal.family
    fill_in "Kingdom", with: @animal.kingdom
    fill_in "Order", with: @animal.order
    fill_in "Phylum", with: @animal.phylum
    click_on "Update Animal"

    assert_text "Animal was successfully updated"
    click_on "Back"
  end

  test "destroying a Animal" do
    visit animals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Animal was successfully destroyed"
  end
end
