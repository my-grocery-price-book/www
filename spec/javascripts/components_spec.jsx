describe('displayPrice', function() {
  it("returns 1.000 for 1", function () {
    expect(displayPrice(1)).toEqual('1.000');
  });

  it("returns 1.000e+5 for 99999", function () {
    expect(displayPrice(99999)).toEqual('1.000e+5');
  });

  it("returns 1.000e+5 for 100000", function () {
    expect(displayPrice(100000)).toEqual('1.000e+5');
  });

  it("returns 1.000e+4 for 10000", function () {
    expect(displayPrice(10000)).toEqual('1.000e+4');
  });

  it("returns 1.000 for 0.9999999999", function () {
    expect(displayPrice(0.9999999999)).toEqual('1.000');
  });

  it("returns 1.111e-6 for 0.0000011111", function () {
    expect(displayPrice(0.0000011111)).toEqual('1.111e-6');
  });

  it("returns 1.111e-4 for 0.00011111", function () {
    expect(displayPrice(0.00011111)).toEqual('1.111e-4');
  });
});

describe('displayPriceRatio', function() {
  it("returns 1.000 / grams for 1, grams", function () {
    expect(displayPriceRatio(1,'grams')).toEqual('1.000 / grams');
  });

  it("returns 1.000 / kilograms for 1000, grams", function () {
    expect(displayPriceRatio(1000,'grams')).toEqual('1.000 / kilograms');
  });

  it("returns 1.000 / kilograms for 1, kilograms", function () {
    expect(displayPriceRatio(1,'kilograms')).toEqual('1.000 / kilograms');
  });

  it("returns 1.000 / grams for 0.01, kilograms", function () {
    expect(displayPriceRatio(0.01,'kilograms')).toEqual('10.00 / grams');
  });

  it("returns 1.000 / milliliters for 1, milliliters", function () {
    expect(displayPriceRatio(1,'milliliters')).toEqual('1.000 / milliliters');
  });

  it("returns 1.000 / liters for 1000, milliliters", function () {
    expect(displayPriceRatio(1000,'milliliters')).toEqual('1.000 / liters');
  });

  it("returns 1.000 / liters for 1, liters", function () {
    expect(displayPriceRatio(1,'liters')).toEqual('1.000 / liters');
  });

  it("returns 1.000 / milliliters for 0.01, kilograms", function () {
    expect(displayPriceRatio(0.01,'liters')).toEqual('10.00 / milliliters');
  });
});