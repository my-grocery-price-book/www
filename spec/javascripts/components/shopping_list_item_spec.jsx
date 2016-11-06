describe('ShoppingListItem', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <ShoppingListItem page={{category: 'bakery', unit: 'grams',
                                 best_entry: {price_per_package: 13.951356,
                                              price_per_unit: 13.951356,
                                              store_name: 'Mr Buy',
                                              amount: 1,
                                              currency_symbol: '$'} }}
                          item={{name: 'Brown Bread', amount: 2}} />
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });

  it("shows item amount", function () {
    const div_item = dom_node.querySelector('[data-amount]');

    expect(div_item.innerText).toContain('2');
  });

  it("shows item name", function () {
    const div_item = dom_node.querySelector('[data-name]');

    expect(div_item.innerText).toContain('Brown Bread');
  });

  it("shows comparing store", function () {
    const div_item = dom_node.querySelector('[data-comparing-store]');

    expect(div_item.innerText).toContain('Mr Buy');
  });

  it("shows page unit", function () {
    const div_item = dom_node.querySelector('[data-comparing-unit]');

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

  it("it increases amount", function () {
    const form = dom_node.querySelector('[data-amount-change="increase"]');
    expect(form.nodeName).toEqual('FORM');

    TestUtils.Simulate.submit(form);

    const div_item = dom_node.querySelector('[data-amount]');
    expect(div_item.innerText).toContain('3');
  });

  it("it decreases amount", function () {
    const form = dom_node.querySelector('[data-amount-change="decrease"]');
    expect(form.nodeName).toEqual('FORM');

    TestUtils.Simulate.submit(form);

    const div_item = dom_node.querySelector('[data-amount]');
    expect(div_item.innerText).toContain('1');
  });

  it("it wont decreases amount less than 1", function () {
    const form = dom_node.querySelector('[data-amount-change="decrease"]');
    expect(form.nodeName).toEqual('FORM');

    TestUtils.Simulate.submit(form);
    TestUtils.Simulate.submit(form);

    const div_item = dom_node.querySelector('[data-amount]');
    expect(div_item.innerText).toContain('1');
  });
});