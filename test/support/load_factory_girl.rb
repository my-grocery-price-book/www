FactoryGirl.lint
DatabaseCleaner.clean_with :truncation # clear our database again after linting

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end

# MiniTest::Spec
class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end
