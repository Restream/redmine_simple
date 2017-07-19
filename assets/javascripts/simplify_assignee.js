function simplifyAssignee() {
  var selectId = "#issue_assigned_to_id";

  if (jql(selectId).length == 0) return;

  var initialData = jql(selectId).data("initial");

  var simpleMode = jql(selectId).parents(".simple-box").length > 0;

  var selectWidth = "60%";
  // try to determine actual width of select
  try {
    var
      selectCtrl          = jql("#issue-form #attributes select").first()[0],
      selectCtrlContainer = jql(selectId).parent()[0],
      sWidth              = window.getComputedStyle(selectCtrl).width,
      cWidth              = window.getComputedStyle(selectCtrlContainer).width,
      percentWidth        = Math.round(100 * parseFloat(sWidth) / parseFloat(cWidth));

    if (percentWidth > 0) {
      selectWidth = percentWidth + "%";
    }
  } catch (e) {
  }

  var assigneeWidth = simpleMode ? "20%" : selectWidth;

  jql(selectId)
  .select2({
    width: assigneeWidth,
    allowClear: true,
    placeholder: ' ',
    query: function (query) {
      if (query.term == "") {
        query.callback(initialData);
      } else {
        var filtered_data = simplifyFilterData(initialData.results, query.term);
        query.callback({
          more: false,
          results: filtered_data
        });
      }
    },
    data: initialData.results
  })
  .on("change", function (e) {
    var assignee = e.added;
    if (assignee && assignee.non_member == true) {
      jql(selectId).select2("data", e.removed);
      showNewMemberModal({
        memberId: assignee.id,
        memberName: assignee.text,
        success: function () {
          jql(selectId).select2("data", assignee);
        }
      });
    }
  });

  jql(selectId).parent('p').addClass('select2-field');
}

jql(document).ready(function () {
  simplifyAssignee();
});
