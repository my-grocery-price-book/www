describe('ShoppingListItem', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <ShoppingListItem page={{category: 'bakery'}}/>
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });

  it("set .category-bakery", function () {
    const div_item = dom_node.querySelector('.shopping-list-item');

    expect(div_item.className).toContain('category-bakery');
  });
});