const TestUtils = React.addons.TestUtils;

describe('ShoppingListTitle', function() {

  describe('show_form false"', function() {
    var shopping_list_title;

    beforeEach(function() {
      shopping_list_title = TestUtils.renderIntoDocument(
          <ShoppingListTitle title="My Title" show_form={false}/>
      );
    });

    it("show title", function () {
      const shopping_list_title_span = ReactDOM.findDOMNode(shopping_list_title).querySelector('#shopping_list_title_span');

      expect(shopping_list_title_span.textContent).toEqual('My Title');
      expect(shopping_list_title_span.style.display).toEqual('');
    });

    it("hides title input", function () {
      const shopping_list_title_input = ReactDOM.findDOMNode(shopping_list_title).querySelector('#shopping_list_title');

      expect(shopping_list_title_input).toBeNull();
    });
  });

  describe('show_form true"', function() {
    var shopping_list_title;

    beforeEach(function() {
      shopping_list_title = TestUtils.renderIntoDocument(
          <ShoppingListTitle title="My Title" show_form={true}/>
      );
    });

    it("shows title input", function () {
      const shopping_list_title_input = ReactDOM.findDOMNode(shopping_list_title).querySelector('#shopping_list_title');

      expect(shopping_list_title_input).toBeDefined();
      expect(shopping_list_title_input.value).toEqual('My Title');
    });

    it("hides title", function () {
      const shopping_list_title_span = ReactDOM.findDOMNode(shopping_list_title).querySelector('#shopping_list_title_span');

      expect(shopping_list_title_span).toBeNull();
    });
  });
});