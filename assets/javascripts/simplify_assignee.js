function simplifyAssignee() {
  var selectId = "#issue_assigned_to_id";

  var clearAssignee = function() {
    $(selectId).select2("data", { id: "", text: "" });
  };

  var isItemLike = function(item, term) {
    var pattern;
    var parts = term.trim().split(/\s+/);
    if (parts.length == 2) {
      // find by 'name surname' pattern if term contains two parts
      // "^sur\S*\s+na|^na\S*\s+sur" should match "Surname Name" and "Name Surname"
      pattern = RegExp("^"+parts[0]+"\\S*\\s+"+parts[1]+"|^"+parts[1]+"\\S*\\s+"+parts[0], "i")
    } else {
      pattern = RegExp(term.trim(), "i");
    }
    // search in text, login, email and name
    return pattern.test(item.text) ||
        pattern.test(item.login || "") ||
        pattern.test(item.email || "") ||
        pattern.test(item.name || "");
  };

  var filterData = function(data, term) {
    var result = [];
    for (var i = 0; i < data.length; i++) {
      var item = data[i];
      if (item.children == undefined) {
        if (isItemLike(item, term)) result.push(item);
      } else {
        var childrenData = filterData(item.children, term);
        if (childrenData.length > 0) {
          result.push({
            text: item.text,
            children: childrenData
          });
        }
      }
    }
    return result;
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
          var filtered_data = filterData(initialData.results, query.term);
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
