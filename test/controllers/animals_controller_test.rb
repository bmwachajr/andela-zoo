require 'test_helper'

class AnimalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @animal = animals(:one)
  end

  test "should get index" do
    get animals_url
    assert_response :success
  end

  test "should get new" do
    get new_animal_url
    assert_response :success
  end

  test "should create animal" do
    assert_difference('Animal.count') do
      post animals_url, params: { animal: { cites_id: @animal.cites_id, animal_class: @animal.animal_class, common_name: @animal.common_name, family: @animal.family, kingdom: @animal.kingdom, order: @animal.order, phylum: @animal.phylum } }
    end

    assert_redirected_to animal_url(Animal.last)
  end

  test "should show animal" do
    get animal_url(@animal)
    assert_response :success
  end

  test "should get edit" do
    get edit_animal_url(@animal)
    assert_response :success
  end

  test "should update animal" do
    patch animal_url(@animal), params: { animal: { cites_id: @animal.cites_id, animal_class: @animal.animal_class, common_name: @animal.common_name, family: @animal.family, kingdom: @animal.kingdom, order: @animal.order, phylum: @animal.phylum } }
    assert_redirected_to animal_url(@animal)
  end

  test "should destroy animal" do
    assert_difference('Animal.count', -1) do
      delete animal_url(@animal)
    end

    assert_redirected_to animals_url
  end
end
