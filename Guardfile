guard :minitest, include: ['plugins', 'test'] do
  # with Minitest::Unit
  watch(%r{^test/unit/(.*)\/?test_(.*)\.rb$})
  watch(%r{^plugins/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
