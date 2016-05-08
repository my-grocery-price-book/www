describe('Page', function() {
  var react_dom;
  var dom_node;

  describe('Without Best Price', function() {
    beforeEach(function () {
      react_dom = TestUtils.renderIntoDocument(
          <Page page={{category: 'Bakery', unit: 'grams'}}/>
      );
      dom_node = ReactDOM.findDOMNode(react_dom);
    });

    it("works", function () {
      const info = dom_node.querySelector('.page-info');
      expect(info.textContent).toContain('Bakery,grams');
    });
  });

  describe('With Best Entry', function() {
    beforeEach(function () {
      react_dom = TestUtils.renderIntoDocument(
          <Page page={{best_entry: {total_price: 10, amount: 1, price_per_unit: 0.1,
                                    package_size: 700, package_unit: 'grams',
                                    store_name: 'Pick n Pay', location: 'Cape Town',
                                    product_name: 'White Bread' }}}/>
      );
      dom_node = ReactDOM.findDOMNode(react_dom);
    });

    it("works", function () {
      const info = dom_node.querySelector('.page-info');
      expect(info.textContent).toContain('White Bread');
      expect(info.textContent).toContain('Pick n Pay');
      expect(info.textContent).toContain('Cape Town');
    });
  });
});