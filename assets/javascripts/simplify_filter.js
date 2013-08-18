function simplifyIsItemLike(item, term) {
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
}

function simplifyFilterData(data, term) {
  var result = [];
  for (var i = 0; i < data.length; i++) {
    var item = data[i];
    if (item.children == undefined) {
      if (simplifyIsItemLike(item, term)) result.push(item);
    } else {
      var childrenData = simplifyFilterData(item.children, term);
      if (childrenData.length > 0) {
        result.push({
          text: item.text,
          children: childrenData
        });
      }
    }
  }
  return result;
}
