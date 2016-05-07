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