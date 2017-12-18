import React from 'react';
import { mount } from 'enzyme';
import ShoppingList from '../../src/ShoppingListsIndex/components/shopping_list';

describe('ShoppingList', function() {
  var react_dom;

  beforeEach(function() {
    react_dom = mount(
        <ShoppingList item_id={"1"} title="My Shopping" item_progress=""/>
    );
  });

  it("works", function () {
    expect(react_dom.name()).toEqual('ShoppingList');
  });
});