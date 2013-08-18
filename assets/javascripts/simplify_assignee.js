function simplifyAssignee() {
  var selectId = "#issue_assigned_to_id";

  if ($(selectId).length == 0 ) return;

  var clearAssignee = function() {
    $(selectId).select2("data", { id: "", text: "" });
  };

  var initialData = $(selectId).data("initial");

  $(selectId)
    .select2({
      width: '60%',
      allowClear: true,
      placeholder: ' ',
      query: function(query) {
        if (query.term == "") {
          query.callback(initialData);
        } else {
          var filtered_data = simplifyFilterData(initialData.results, query.term);
          query.callback({
            more: false,
            results: filtered_data
          });
        }
      }
    })
    .select2("data", {
      id: $(selectId).val(),
      text: $(selectId).data("text")
    })
    .on("change", function(e) {
      var assignee = $(this).select2("data");
      if (assignee && assignee.non_member == true) {
        clearAssignee();
        showNewMemberModal({
          memberId: assignee.id,
          memberName: assignee.text,
          success: function() {
            $(selectId).select2("data", assignee);
          }
        });
      }
    });

  $(selectId).parent('p').addClass('select2-field');
}

$(document).ready(function() {
  simplifyAssignee();
});
