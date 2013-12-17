require File.expand_path('../../../test_helper', __FILE__)

class PatchedIssuesHelperTest < ActionView::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations

  include ApplicationHelper
  include IssuesHelper
  include RedmineSimpleHelper

  def setup
    super
    set_language_if_valid('en')
    @project = Project.find(1)
    @issue = @project.issues.find(1)
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

  def test_assignee_for_select
    user = User.find(1)
    User.current = user
    data = assignee_for_select(@issue)
    assignees = extract_tree_of_ids_from_array(data[:results])
    assert_equal '1,2,2,3,[1,4,7,8,9]', assignees
  end

  def test_watchers_for_select
    user = User.find(1)
    User.current = user
    data = watchers_for_select(@issue)
    watchers = extract_tree_of_ids_from_array(data[:results])
    assert_equal '1,2,3,[1,4,7,8,9]', watchers
  end

  def extract_tree_of_ids_from_array(arr)
    arr.map do |e|
      e.has_key?(:children) ?
          "[#{extract_tree_of_ids_from_array(e[:children])}]" :
          e[:id].to_s
    end.sort.join(',')
  end
end
