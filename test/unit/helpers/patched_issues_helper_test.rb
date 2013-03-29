require File.expand_path('../../../test_helper', __FILE__)

class PatchedIssuesHelperTest < ActionView::TestCase
  include ApplicationHelper
  include IssuesHelper

  def setup
    super
    set_language_if_valid('en')
  end

  def test_link_to_simplify_on
    assert_match l(:text_simplify_on), link_to_simplify_on
  end

  def test_link_to_simplify_off
    assert_match l(:text_simplify_off), link_to_simplify_off
  end
end
