describe('ShoppingListItem', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <ShoppingListItem page={{category: 'bakery', unit: 'grams',
                                 best_entry: {price_per_unit: 0.019928571428571427,
                                              package_size: 700,
                                              currency_symbol: '$'} }}
                          item={{name: 'Brown Bread', amount: '1'}}
                          currency_symbol="$" />
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });

  it("shows item amount", function () {
    const div_item = dom_node.querySelector('[data-amount]');

    expect(div_item.innerText).toContain('1');
  });

  it("shows item name", function () {
    const div_item = dom_node.querySelector('[data-name]');

    expect(div_item.innerText).toContain('Brown Bread');
  });

  it("shows page unit", function () {
    const div_item = dom_node.querySelector('[data-unit]');

    expect(div_item.innerText).toContain('grams');
  });

  it("shows comparing price", function () {
    const div_item = dom_node.querySelector('[data-comparing-price]');

    expect(div_item.innerText).toContain('$13.95');
  });

  it("set .category-bakery", function () {
    const div_item = dom_node.querySelector('.shopping-list-item');

    expect(div_item.className).toContain('category-bakery');
  });
});