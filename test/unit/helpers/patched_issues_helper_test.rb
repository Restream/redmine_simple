require File.expand_path('../../../test_helper', __FILE__)

class PatchedIssuesHelperTest < ActionView::TestCase
  include ApplicationHelper
  include IssuesHelper

  def setup
    super
    set_language_if_valid('en')
    @project = Project.find(1)
    @issue = @project.issues.first
  end

  def test_link_to_new_issue_simplify_on
    assert_match l(:text_simplify_on), link_to_new_issue_simplify_on(@project)
  end

  def test_link_to_new_issue_simplify_off
    assert_match l(:text_simplify_off), link_to_new_issue_simplify_off(@project)
  end

  def test_link_to_edit_issue_simplify_on
    assert_match l(:text_simplify_on), link_to_edit_issue_simplify_on(@issue)
  end

  def test_link_to_edit_issue_simplify_off
    assert_match l(:text_simplify_off), link_to_edit_issue_simplify_off(@issue)
  end
end
