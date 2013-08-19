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

  def test_assignee_for_select
    user = User.find(1)
    User.current = user

    data = assignee_for_select(@issue)
    expected_data = { :more => false,
                      :results =>
                          [{ :email => "admin@somenet.foo",
                             :id => 1,
                             :login => "admin",
                             :name => "redMine Admin",
                             :text => "<< me >>" },
                           {:email => "jsmith@somenet.foo",
                            :id => 2,
                            :login => "jsmith",
                            :name => "John Smith",
                            :text => "<< Author >>"},
                           { :email => "dlopper@somenet.foo",
                             :id => 3,
                             :login => "dlopper",
                             :text => "Dave Lopper" },
                           { :email => "jsmith@somenet.foo",
                             :id => 2,
                             :login => "jsmith",
                             :text => "John Smith" },
                           { :children =>
                                 [{ :email => "admin@somenet.foo",
                                    :id => 1,
                                    :login => "admin",
                                    :non_member => true,
                                    :text => "redMine Admin" },
                                  { :email => "rhill@somenet.foo",
                                    :id => 4,
                                    :login => "rhill",
                                    :non_member => true,
                                    :text => "Robert Hill" },
                                  { :email => "someone@foo.bar",
                                    :id => 7,
                                    :login => "someone",
                                    :non_member => true,
                                    :text => "Some One" },
                                  { :email => "miscuser8@foo.bar",
                                    :id => 8,
                                    :login => "miscuser8",
                                    :non_member => true,
                                    :text => "User Misc" },
                                  { :email => "miscuser9@foo.bar",
                                    :id => 9,
                                    :login => "miscuser9",
                                    :non_member => true,
                                    :text => "User Misc" }],
                             :text => "Non member" }] }
    assert_equal expected_data, data
  end

  def test_watchers_for_select
    user = User.find(1)
    User.current = user

    data = watchers_for_select(@issue)
    expected_data = { :more => false,
                      :results =>
                          [{ :email => "admin@somenet.foo",
                             :id => 1,
                             :login => "admin",
                             :name => "redMine Admin",
                             :text => "<< me >>" },
                           { :email => "dlopper@somenet.foo",
                             :id => 3,
                             :login => "dlopper",
                             :text => "Dave Lopper" },
                           { :email => "jsmith@somenet.foo",
                             :id => 2,
                             :login => "jsmith",
                             :text => "John Smith" },
                           { :children =>
                                 [{ :email => "admin@somenet.foo",
                                    :id => 1,
                                    :login => "admin",
                                    :non_member => true,
                                    :text => "redMine Admin" },
                                  { :email => "rhill@somenet.foo",
                                    :id => 4,
                                    :login => "rhill",
                                    :non_member => true,
                                    :text => "Robert Hill" },
                                  { :email => "someone@foo.bar",
                                    :id => 7,
                                    :login => "someone",
                                    :non_member => true,
                                    :text => "Some One" },
                                  { :email => "miscuser8@foo.bar",
                                    :id => 8,
                                    :login => "miscuser8",
                                    :non_member => true,
                                    :text => "User Misc" },
                                  { :email => "miscuser9@foo.bar",
                                    :id => 9,
                                    :login => "miscuser9",
                                    :non_member => true,
                                    :text => "User Misc" }],
                             :text => "Non member" }] }
    assert_equal expected_data, data
  end
end
