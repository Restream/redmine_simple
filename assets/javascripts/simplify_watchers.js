function simplifyWatchers(url) {
  $(document).ready(function() {

    $("#issue_select2_watcher_user_ids").select2({
      width: "60%",
      multiple: true,
      ajax: {
        url: url,
        data: function(term,page) { return { term: term }; },
        results: function(data, page) { return data; }
      }
    });

    var initialData = $("#issue_select2_watcher_user_ids").data("initial");
    if (initialData !== "") {
      $("#issue_select2_watcher_user_ids").select2("data", initialData);
    }

    $("#issue_select2_watcher_user_ids").parent('p').addClass('select2-field');

  });
}
