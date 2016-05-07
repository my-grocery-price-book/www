describe('PagesIndex', function() {
  var react_dom;
  var dom_node;

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <PagesIndex pages={[]}/>
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("works", function () {
    expect(dom_node.nodeName).toEqual('DIV');
  });
});