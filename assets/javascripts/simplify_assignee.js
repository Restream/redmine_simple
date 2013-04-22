function simplifyAssignee(url) {
  $(document).ready(function() {

    var clearAssignee = function() {
      $("#issue_assigned_to_id").select2("data", { id: "", text: "" });
    };

    $("#issue_assigned_to_id")
        .select2({
          width: '60%',
          allowClear: true,
          placeholder: ' ',
          ajax: {
            url: url,
            data: function(term, page) { return { term: term }; },
            results: function(data, page) { return data; }
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

    $("#issue_assigned_to_id").parent('p').addClass('select2-field');

  });
}

