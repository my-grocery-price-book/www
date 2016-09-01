describe('Book', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <Book pages={[{id: 1, name: 'Bread', category: 'Bakery', unit: 'grams',
          best_entry: {product_name: 'Woolworths White Bread', amount: 1,
            package_size: 700, package_unit: 'grams',
            price_per_package: 700 * 0.77,
            price_per_unit: 0.77, store_name: 'Woolworths',
            location: 'Cape Town', total_price: 13.95 }},
          {id: 2, name: 'Large Eggs', category: 'Fresh', unit: 'items'}]}/>
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });

  describe('Filtering', function() {
    var input_filter;

    beforeEach(function() {
      input_filter = react_dom.refs.input_filter;
    });

    it("filters out on name", function () {
      input_filter.value = "Bre";
      TestUtils.Simulate.change(input_filter);

      const bread = dom_node.querySelector('[data-page-name="Bread"]');
      expect(bread.style.display).toEqual('');
      const eggs = dom_node.querySelector('[data-page-name="Large Eggs"]');
      expect(eggs.style.display).toEqual('none');
    });

    it("filters out on name case insensitive", function () {
      input_filter.value = "bre";
      TestUtils.Simulate.change(input_filter);

      const bread = dom_node.querySelector('[data-page-name="Bread"]');
      expect(bread.style.display).toEqual('');
      const eggs = dom_node.querySelector('[data-page-name="Large Eggs"]');
      expect(eggs.style.display).toEqual('none');
    });

    it("filters out on category", function () {
      input_filter.value = "Fre";
      TestUtils.Simulate.change(input_filter);

      const bread = dom_node.querySelector('[data-page-name="Bread"]');
      expect(bread.style.display).toEqual('none');
      const eggs = dom_node.querySelector('[data-page-name="Large Eggs"]');
      expect(eggs.style.display).toEqual('');
    });

    it("filters out on category case insensitive", function () {
      input_filter.value = "fre";
      TestUtils.Simulate.change(input_filter);

      const bread = dom_node.querySelector('[data-page-name="Bread"]');
      expect(bread.style.display).toEqual('none');
      const eggs = dom_node.querySelector('[data-page-name="Large Eggs"]');
      expect(eggs.style.display).toEqual('');
    });
  });
});