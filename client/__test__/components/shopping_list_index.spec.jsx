import React from 'react';
import { mount } from 'enzyme';
import ShoppingListIndex from '../../app/bundles/ShoppingListsIndex/components/shopping_list_index';

describe('ShoppingListIndex', function() {
  var react_dom;

  beforeEach(function() {
    react_dom = mount(
      <ShoppingListIndex initial_lists={[]}/>
    );
  });

  it("works", function () {
    expect(react_dom.name()).toEqual('ShoppingListIndex');
  });
});