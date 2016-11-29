import React from 'react';
import { mount } from 'enzyme';
import Book from '../../app/bundles/PriceBook/components/book';

describe('Book', function() {
  var react_dom;

  beforeEach(function() {
    react_dom = mount(
        <Book pages={[{id: 1, name: 'Bread', category: 'Bakery', unit: 'grams',
          best_entry: {product_name: 'Woolworths White Bread', amount: 1,
            package_size: 700, package_unit: 'grams',
            price_per_package: 700 * 0.77,
            price_per_unit: 0.77, store_name: 'Woolworths',
            location: 'Cape Town', total_price: 13.95 }},
          {id: 2, name: 'Large Eggs', category: 'Fresh', unit: 'items'}]}/>
    );
  });

  it("works", function () {
    expect(react_dom.name()).toEqual('Book');
  });

  describe('Filtering', function() {
    var input_filter;

    beforeEach(function() {
      input_filter = react_dom.ref('input_filter');
    });

    it("filters out on name", function () {
      input_filter.simulate('change', {target: {value: 'Bre'}});

      const bread = react_dom.find('[data-page-name="Bread"]');
      expect(bread.prop('style')).toBeNull();
      const eggs = react_dom.find('[data-page-name="Large Eggs"]');
      expect(eggs.prop('style')).toEqual({display: 'none'});
    });

    it("filters out on name case insensitive", function () {
      input_filter.simulate('change', {target: {value: 'bre'}});

      const bread = react_dom.find('[data-page-name="Bread"]');
      expect(bread.prop('style')).toBeNull();
      const eggs = react_dom.find('[data-page-name="Large Eggs"]');
      expect(eggs.prop('style')).toEqual({display: 'none'});
    });

    it("filters out on category", function () {
      input_filter.simulate('change', {target: {value: 'Fre'}});

      const bread = react_dom.find('[data-page-name="Bread"]');
      expect(bread.prop('style')).toEqual({display: 'none'});
      const eggs = react_dom.find('[data-page-name="Large Eggs"]');
      expect(eggs.prop('style')).toBeNull();
    });

    it("filters out on category case insensitive", function () {
      input_filter.simulate('change', {target: {value: 'fre'}});

      const bread = react_dom.find('[data-page-name="Bread"]');
      expect(bread.prop('style')).toEqual({display: 'none'});
      const eggs = react_dom.find('[data-page-name="Large Eggs"]');
      expect(eggs.prop('style')).toBeNull();
    });
  });
});