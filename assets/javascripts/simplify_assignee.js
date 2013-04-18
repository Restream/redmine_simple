function simplifyAssigneeField(url) {
  $(document).ready(function() {

    $("#issue_assigned_to_id").select2({
      width: '60%',
      allowClear: true,
      placeholder: ' ',
      ajax: {
        url: url,
        data: function(term, page) {
          return {
            term: term
          };
        },
        results: function(data, page) {
          return jQuery.parseJSON(data);
        }
      }
//      ,
//      initSelection: function(element, callback) {
//        var id = $(element).val();
//        if (id !== "") {
//          $.ajax(url).done(
//            function(data) { callback(jQuery.parseJSON(data)); }
//          );
//        }
//      }
    });

    $("#issue_assigned_to_id").select2("data", {
      id: $("#issue_assigned_to_id").val(),
      text: $("#issue_assigned_to_id").data("text")
    });
  });
}

