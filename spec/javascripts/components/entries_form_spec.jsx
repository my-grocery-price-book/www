describe('EntriesFormSpec', function() {
  var react_dom;
  var dom_node;

  function localBloodhound(l) {
    return new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      sufficient: 3,
      local: l
    });
  }

  beforeEach(function() {
    react_dom = TestUtils.renderIntoDocument(
        <EntriesForm entry={{total_price: 100, date_on: "2016-01-21", product_name: "Beans",
                             amount: 10, package_size: 20}}
                     package_unit="KG" back_href="/back" new_store_href="/new_store"
                     create_url="/save" bloodhoundBuilder={localBloodhound}
                     error_messages={['Message 1']}
                     local_sugesstion={['Bread', 'Oranges', 'Cheese', 'Chicken', 'Carrots', 'Corn', 'Chips']}
                     selectable_stores={[]} />
    );
    dom_node = ReactDOM.findDOMNode(react_dom);
  });

  it("sets initial package_size", function () {
    const input = dom_node.querySelector('#package_size');

    expect(input.value).toEqual("20");
  });

  it("sets initial total_price", function () {
    const input = dom_node.querySelector('#total_price');

    expect(input.value).toEqual("100");
  });

  it("sets initial date_on", function () {
    const input = dom_node.querySelector('#date_on');

    expect(input.value).toEqual("2016-01-21");
  });

  it("sets initial product_name", function () {
    const input = dom_node.querySelector('#product_name');

    expect(input.value).toEqual("Beans");
  });

  it("sets initial amount", function () {
    const input = dom_node.querySelector('#amount');

    expect(input.value).toEqual("10");
  });

  it("shows package_unit", function () {
    const span = dom_node.querySelector('#package_unit');

    expect(span.textContent).toEqual("KG");
  });

  it("sets back link", function () {
    const a = dom_node.querySelector('a[href="/back"]');

    expect(a.nodeName).toEqual("A");
  });

  it("sets new store link", function () {
    const a = dom_node.querySelector('a[href="/new_store"]');

    expect(a.nodeName).toEqual("A");
  });

  it("sets form#action", function () {
    expect(dom_node.getAttribute('action')).toEqual('/save');
  });
});