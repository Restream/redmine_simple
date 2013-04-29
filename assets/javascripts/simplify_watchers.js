function simplifyWatchers(url) {
  $(document).ready(function() {

    $.ajax(url).success(function(initialData) {

      $("#issue_select2_watcher_user_ids").select2({
        width: "60%",
        multiple: true,
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
      });

    });

    var initialData = $("#issue_select2_watcher_user_ids").data("initial");
    if (initialData !== "") {
      $("#issue_select2_watcher_user_ids").select2("data", initialData);
    }

    $("#issue_select2_watcher_user_ids").parent('p').addClass('select2-field');

  });
}
