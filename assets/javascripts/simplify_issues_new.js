$(document).ready(function() {

  var simplifyIssueNew = function() {
    // Hide all stuff except an attributes
    $('form#issue-form.new_issue div.box.tabular').children().not('#all_attributes').hide();

    // Hide top attributes
    var except = [
      $('#issue_subject').parents('p:first')[0],
      $('#issue_description').parents('p:first')[0],
      $('#attributes')[0]
    ];

    $('#all_attributes').children().not(except).hide();

    // Hide other attributes
    except = [
      $('#issue_assigned_to_id').parents('p:first')[0]
    ];

    $('#attributes p').not(except).hide();
  };

  var restoreIssueNew = function() {
    $('form#issue-form.new_issue div.box.tabular').children().show();
    $('#all_attributes').children().show();
    $('#attributes p').show();
  };

  var updateIssueNewFields = function() {
    var simplify = $('input#simplify')[0].checked;

    if (simplify) {
      simplifyIssueNew();
    } else {
      restoreIssueNew();
    }
  };

  $('input#simplify').on('click', updateIssueNewFields);

  updateIssueNewFields();
});
