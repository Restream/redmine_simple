function simplifyAssignee(url) {
  $(document).ready(function() {

    var clearAssignee = function() {
      $("#issue_assigned_to_id").select2("data", { id: "", text: "" });
    };

    $.ajax(url).success(function(initialData) {

      $("#issue_assigned_to_id")
        .select2({
          width: '60%',
          allowClear: true,
          placeholder: ' ',
          query: function(query) {
            if (query.term == "") {
              query.callback(initialData);
            } else {
              $.ajax({
                url: url,
                data: { term: query.term }
              }).success(function(data) { query.callback(data) });
            }
          }
        })
        .select2("data", {
          id: $("#issue_assigned_to_id").val(),
          text: $("#issue_assigned_to_id").data("text")
        })
        .on("change", function(e) {
          var assignee = $(this).select2('data');
          if (assignee && assignee.non_member == true) {
            clearAssignee();
            showNewMemberModal({
              memberId: assignee.id,
              memberName: assignee.text,
              success: function() {
                $("#issue_assigned_to_id").select2("data", assignee);
              }
            });
          }
        });
    });

    $("#issue_assigned_to_id").parent('p').addClass('select2-field');

  });
}

