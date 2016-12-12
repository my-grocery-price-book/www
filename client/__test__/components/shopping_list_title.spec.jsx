import React from 'react';
import { mount } from 'enzyme';
import ShoppingListTitle from '../../app/bundles/ShoppingListsIndex/components/shopping_list_title';

describe('ShoppingListTitle', function() {

  describe('show_form false"', function() {
    var shopping_list_title;

    beforeEach(function() {
      shopping_list_title = mount(
          <ShoppingListTitle title="My Title" show_form={false}/>
      );
    });

    it("show title", function () {
      const shopping_list_title_span = shopping_list_title.find('#shopping_list_title_span');

      expect(shopping_list_title_span.text()).toEqual('My Title');
      expect(shopping_list_title_span.prop('style')).toBeUndefined();
    });

    it("hides title input", function () {
      const shopping_list_title_input = shopping_list_title.find('#shopping_list_title');

      expect(shopping_list_title_input.length).toEqual(0);
    });
  });

  describe('show_form true"', function() {
    var shopping_list_title;

    beforeEach(function() {
      shopping_list_title = mount(
          <ShoppingListTitle title="My Title" show_form={true}/>
      );
    });

    it("shows title input", function () {
      const shopping_list_title_input = shopping_list_title.find('#shopping_list_title');

      expect(shopping_list_title_input).toBeDefined();
      expect(shopping_list_title_input.prop('value')).toEqual('My Title');
    });

    it("hides title", function () {
      const shopping_list_title_span = shopping_list_title.find('#shopping_list_title_span');

      expect(shopping_list_title_span.length).toEqual(0);
    });
  });
});