# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

if Comfy::Cms::Site.count == 0
  Comfy::Cms::Site.create!(identifier: 'main-site', hostname: 'example.com')
  ComfortableMexicanSofa::Fixture::Importer.new('main-site', 'main-site', :force).import!
end
