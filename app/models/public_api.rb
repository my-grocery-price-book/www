class PublicApi < Struct.new(:code, :name,:url)
  def self.find_by_code(code)
    all.find{|api| api.code == code}
  end

  def self.first_code
    all.first.code
  end

  def self.all
    [
      ['za-ec','Eastern Cape', 'za-ec.public-grocery-price-book-api.co.za'],
      ['za-fs','Free State', 'za-fs.public-grocery-price-book-api.co.za'],
      ['za-gt','Gauteng','za-gt.public-grocery-price-book-api.co.za'],
      ['za-nl','KwaZulu-Natal', 'za-nl.public-grocery-price-book-api.co.za'],
      ['za-lp','Limpopo', 'za-lp.public-grocery-price-book-api.co.za'],
      ['za-mp','Mpumalanga', 'za-mp.public-grocery-price-book-api.co.za'],
      ['za-nc','Northern Cape', 'za-nc.public-grocery-price-book-api.co.za'],
      ['za-nw','North West', 'za-nw.public-grocery-price-book-api.co.za'],
      ['za-wc','Western Cape', 'za-wc.public-grocery-price-book-api.co.za']
    ].map{|code,name,url| new(code,name,url) }
  end
end
