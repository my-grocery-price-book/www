import React from 'react';
import { mount } from 'enzyme';
import EntriesForm from '../../src/EntriesForm/components/entries_form';
var Bloodhound = require('bloodhound-js');

describe('EntriesFormSpec', function() {
  var dom_node;
  var remote_url;

  function localBloodhound(l,r) {
    remote_url = r;
    return new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      sufficient: 3,
      local: l
    });
  }

  beforeEach(function() {
    dom_node = mount(
        <EntriesForm entry={{total_price: 100, date_on: "2016-01-21", product_name: "Beans",
                             amount: 10, package_size: 20, store_id: 2}}
                     package_unit="KG" back_href="/back" new_store_href="/new_store"
                     form_action="/save" bloodhoundBuilder={localBloodhound}
                     error_messages={['Message 1']}
                     local_sugesstion={['Bread', 'Oranges', 'Cheese', 'Chicken', 'Carrots', 'Corn', 'Chips']}
                     entry_names_url="/my_other"
                     selectable_stores={[['Store 1',"1"],['Store 2', "2"]]} />
    ).render();
  });

  it("sets initial package_size", function () {
    const input = dom_node.find('#package_size');

    expect(input.attr('value')).toEqual("20");
  });

  it("sets initial total_price", function () {
    const input = dom_node.find('#total_price');

    expect(input.attr('value')).toEqual("100");
  });

  it("sets initial date_on", function () {
    const input = dom_node.find('#date_on');

    expect(input.attr('value')).toEqual("2016-01-21");
  });

  it("sets initial product_name", function () {
    const input = dom_node.find('#product_name');

    expect(input.attr('value')).toEqual("Beans");
  });

  it("sets initial amount", function () {
    const input = dom_node.find('#amount');

    expect(input.attr('value')).toEqual("10");
  });

  it("shows package_unit", function () {
    const span = dom_node.find('#package_unit');

    expect(span.text()).toEqual("KG");
  });

  it("sets back link", function () {
    const a = dom_node.find('a[href="/back"]');

    expect(a.text()).toEqual("Back");
  });

  it("sets new store link", function () {
    const a = dom_node.find('a[href="/new_store"]');

    expect(a.text()).toEqual("New Store");
  });

  it("sets form#action", function () {
    expect(dom_node.attr('action')).toEqual('/save');
  });

  it("sets remote_url", function () {
    expect(remote_url).toEqual('/my_other');
  });
});