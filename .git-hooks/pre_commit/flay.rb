module Overcommit::Hook::PreCommit
  class Flay < Base
    # Overcommit expects you to override this method which will be called
    # everytime your pre-commit hook is run.
    def run
      directories = %w(app lib test config)
      output = `flay #{directories.join(' ')} --mass 53`
      if output.include? 'Total score (lower is better) = 0'
        :pass
      else
        [:fail, output]
      end
    end
  end
end
