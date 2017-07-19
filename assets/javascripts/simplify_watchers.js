function simplifyWatchers() {
  var selectId = "#issue_select2_watcher_user_ids";

  if (jql(selectId).length == 0 ) return;

  var initialData = jql(selectId).data("initial");

  jql(selectId).
    select2({
      width: "60%",
      multiple: true,
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
    }).select2("data", jql(selectId).data("selected"));

  jql(selectId).parent('p').addClass('select2-field');
}

jql(document).ready(function() {
  simplifyWatchers();
});
