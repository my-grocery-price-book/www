import React from 'react';
import { mount } from 'enzyme';
import Page from '../../app/bundles/PriceBook/components/page';

describe('Page', function() {
  var react_dom;

  describe('Without Best Price', function() {
    beforeEach(function () {
      react_dom = mount(
          <Page page={{category: 'Bakery', unit: 'grams'}}/>
      );
    });

    it("works", function () {
      const info = react_dom.find('.page-info');
      expect(info.text()).toContain('Bakery,grams');
    });
  });

  describe('With Best Entry', function() {
    beforeEach(function () {
      react_dom = mount(
          <Page page={{best_entry: {total_price: 10, amount: 1, price_per_unit: 0.1,
                                    package_size: 700, package_unit: 'grams',
                                    store_name: 'Pick n Pay', location: 'Cape Town',
                                    product_name: 'White Bread' }}}/>
      );
    });

    it("works", function () {
      const info = react_dom.find('.page-info');
      expect(info.text()).toContain('White Bread');
      expect(info.text()).toContain('Pick n Pay');
      expect(info.text()).toContain('Cape Town');
    });
  });
});