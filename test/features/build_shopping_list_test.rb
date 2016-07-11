require 'features_helper'

class BuildShoppingListTest < FeatureTest
  def create_shopping_list(shopper)
    assert shopper.has_text?('Shopping List')
    shopper.perform do
      click_on 'New Shopping List'
      fill_in 'Item name', with: 'bread'
      click_button 'Add'
    end

    assert shopper.has_text?('bread')

    shopper.perform do
      fill_in 'Item name', with: 'eggs'
      click_button 'Add'
    end

    assert shopper.has_text?('bread')
    assert shopper.has_text?('eggs')

    shopper.perform do
      fill_in 'Item name', with: 'milk'
      click_button 'Add'
    end

    assert shopper.has_text?('bread')
    assert shopper.has_text?('eggs')
    assert shopper.has_text?('milk')

    shopper.perform do
      within('[data-item-name="bread"]') do
        click_on 'purchased'
      end

      within('[data-item-name="eggs"]') do
        click_on 'delete'
        click_on 'OK' # confirm the delete
      end
    end

    shopper.using_wait_time(5) do
      assert shopper.has_no_text?('eggs')
      assert shopper.has_text?('bread')
      assert shopper.has_text?('milk')
    end
  end

  test 'create shopping list as logged in shopper' do
    @shopper = ShopperPersonaSession.new(email: 'shopper@example.com')
    @shopper.sign_up
    @shopper.perform do
      visit '/shopping_lists'
    end
    create_shopping_list(@shopper)
  end

  test 'create shopping list as guest' do
    @guest = ShopperPersonaSession.new
    @guest.perform do
      visit '/shopping_lists'
      click_button 'Log in as Guest'
    end
    create_shopping_list(@guest)
  end
end
