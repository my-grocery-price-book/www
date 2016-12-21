import React from 'react';
import { mount } from 'enzyme';
import ShoppingListItem from '../../app/bundles/ShoppingList/components/shopping_list_item';

describe('ShoppingListItem', function() {
  var react_dom;

  beforeEach(function() {
    react_dom = mount(
        <ShoppingListItem page={{category: 'bakery', unit: 'grams',
                                 best_entry: {price_per_package: 13.951356,
                                              price_per_unit: 13.951356,
                                              total_price: 13.951356,
                                              store_name: 'Mr Buy',
                                              amount: 1,
                                              currency_symbol: '$'} }}
                          item={{name: 'Brown Bread', amount: 2}} />
    );
  });

  it("works", function () {
    expect(react_dom.name()).toEqual('ShoppingListItem');
  });

  it("shows item amount", function () {
    const div_item = react_dom.find('[data-amount]');

    expect(div_item.text()).toContain('2');
  });

  it("shows item name", function () {
    const div_item = react_dom.find('[data-name]');

    expect(div_item.text()).toContain('Brown Bread');
  });

  it("shows comparing store", function () {
    const div_item = react_dom.find('[data-comparing-store]');

    expect(div_item.text()).toContain('Mr Buy');
  });

  it("shows page unit", function () {
    const div_item = react_dom.find('[data-comparing-unit]');

    expect(div_item.text()).toContain('grams');
  });

  it("shows comparing price", function () {
    const div_item = react_dom.find('[data-comparing-price]');

    expect(div_item.text()).toContain('$13.95');
  });

  it("set .category-bakery", function () {
    const div_item = react_dom.find('.shopping-list-item');

    expect(div_item.hasClass('category-bakery')).toEqual(true);
  });
});