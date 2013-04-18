function simplifyAssignee(url) {
  $(document).ready(function() {

    $("#issue_assigned_to_id").select2({
      width: '60%',
      allowClear: true,
      placeholder: ' ',
      ajax: {
        url: url,
        data: function(term, page) { return { term: term }; },
        results: function(data, page) { return data; }
      }
    });

    $("#issue_assigned_to_id").select2("data", {
      id: $("#issue_assigned_to_id").val(),
      text: $("#issue_assigned_to_id").data("text")
    });
  });
}

