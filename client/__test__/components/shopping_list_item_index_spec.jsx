describe('ShoppingListItemIndex', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <ShoppingListItemIndex initial_items={[]}
                               shopping_list={{name: 'My List', price_book_pages_url: '/'}} />
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });
});