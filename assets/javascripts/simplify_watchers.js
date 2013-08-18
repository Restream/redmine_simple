function simplifyWatchers() {
  var selectId = "#issue_select2_watcher_user_ids";

  if ($(selectId).length == 0 ) return;

  var initialData = $(selectId).data("initial");

  $(selectId).
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
    }).select2("data", $(selectId).data("selected"));

  $(selectId).parent('p').addClass('select2-field');
}

$(document).ready(function() {
  simplifyWatchers();
});
