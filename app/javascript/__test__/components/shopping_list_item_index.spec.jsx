import React from 'react';
import { mount } from 'enzyme';
import ShoppingListItemIndex from '../../src/ShoppingList/components/shopping_list_item_index';

describe('ShoppingListItemIndex', function() {
  var react_dom;

  beforeEach(function() {
    react_dom = mount(
        <ShoppingListItemIndex initial_items={[]}
                               shopping_list={{name: 'My List', price_book_pages_url: '/'}} />
    );
  });

  it("works", function () {
    expect(react_dom.name()).toEqual('ShoppingListItemIndex');
  });
});