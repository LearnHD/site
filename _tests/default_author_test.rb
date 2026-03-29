require 'test/unit'
require 'yaml'

class DefaultAuthorTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('_config.yml')
  end

  def test_default_author_configuration
    # Check if defaults for posts exist
    assert_not_nil @config['defaults'], "Defaults section should exist in _config.yml"
    
    # Find the post-specific defaults
    post_defaults = @config['defaults'].find { |default| default['scope']['type'] == 'posts' }
    assert_not_nil post_defaults, "Should have defaults for posts"
    
    # Check author details
    author = post_defaults['values']['author']
    assert_not_nil author, "Author configuration should exist"
    assert_not_nil author['name'], "Author name should be specified"
    assert_not_nil author['bio'], "Author bio should be specified"
    
    # Validate author name length
    assert author['name'].length > 0, "Author name should not be empty"
    assert author['name'].length <= 100, "Author name should be 100 characters or less"
  end
end