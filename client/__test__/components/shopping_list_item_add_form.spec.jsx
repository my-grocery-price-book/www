import React from 'react';
import { mount } from 'enzyme';
import ShoppingListItemAddForm from '../../app/bundles/ShoppingList/components/shopping_list_item_add_form';
var Bloodhound = require('bloodhound-js');

describe('ShoppingListItemAddForm', function() {
  var react_dom;
  var names_added;
  var prefetch_url;
  var remote_url;
  var local_bloodhound;

  function localBloodhound(p,r) {
    prefetch_url = p;
    remote_url = r;
    local_bloodhound = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      sufficient: 3,
      local: ['Bread', 'Oranges', 'Cheese', 'Chicken', 'Carrots', 'Corn', 'Chips']
    });
    return local_bloodhound;
  }

  function stubAdd(name) {
    names_added.push(name);
  }

  beforeEach(function() {
    names_added = [];
    react_dom = mount(
        <ShoppingListItemAddForm handleAdd={stubAdd}
                                 bloodhoundBuilder={localBloodhound}
                                 price_book_pages_url="/my_url"
                                 item_names_url="/my_other"
                                 authenticity_token="asd"/>
    );
  });

  it("renders", function () {
    expect(react_dom.name()).toEqual('ShoppingListItemAddForm');
  });

  it("sets prefetch_url", function () {
    expect(prefetch_url).toEqual('/my_url');
  });

  it("sets remote_url", function () {
    expect(remote_url).toEqual('/my_other');
  });

  it("enables input", function () {
    const input = react_dom.find('#shopping_list_item_name');

    expect(input.prop('disabled')).toBeFalsy();
  });

  it("enables button", function () {
    const button = react_dom.find('button');

    expect(button.prop('disabled')).toBeFalsy();
  });

  it("adds the item", function () {
    const input = react_dom.find('#shopping_list_item_name');
    const form = react_dom.find('form');

    input.simulate('change', {target: {value: 'Cheese'}});
    form.simulate('submit');

    expect(names_added).toEqual(["Cheese"]);
  });

  describe('suggestions', function() {
    beforeEach(async function() {
      await local_bloodhound.initialize();
    });

    it("adds the item from suggestion", function () {
      const input = react_dom.find('#shopping_list_item_name');
      input.value = 'Br';
      input.simulate('change', {target: {value: 'Br'}});

      const first_suggestion = react_dom.find('button.name-suggestion').at(0);
      first_suggestion.simulate('click');

      expect(names_added).toEqual(["Bread"]);
    });

    it("shows only 3 suggestions", function () {
      const input = react_dom.find('#shopping_list_item_name');
      expect(react_dom.state().bloodhound_initialized).toEqual(true);

      input.simulate('change', {target: {value: 'C'}});

      const buttons = react_dom.find('button.name-suggestion');

      expect(buttons.length).toEqual(3);
    });
  });

  describe('disabled', function() {
    beforeEach(function() {
      react_dom.setProps({disabled: true});
    });

    it("disables input", function () {
      const input = react_dom.find('#shopping_list_item_name');

      expect(input.prop('disabled')).toBeTruthy();
    });

    it("disables button", function () {
      const button = react_dom.find('button');

      expect(button.prop('disabled')).toBeTruthy();
    });
  });
});