guard :minitest, include: ['plugins', 'test'] do
  # with Minitest::Unit
  watch(%r{^test/(.*/)?([^/]+)\_test.rb$})
  watch(%r{^plugins/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }
end
