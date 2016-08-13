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
});