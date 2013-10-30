function reloadIssueFrom(url) {
  var form = $('#issue-form');
  form.attr('action', url);
  form.attr('method', 'GET');
  form.trigger('submit');
}

$(document).ready(function() {
  $('div#content').on('click', 'a.simplify-on', function() {
    $('#issue-form').append('<input type="hidden" name="simplify" value="on"/>');
    reloadIssueFrom(this.href);
    return false;
  });
  $('div#content').on('click', 'a.simplify-off', function() {
    $('#issue-form').append('<input type="hidden" name="simplify" value="off"/>');
    reloadIssueFrom(this.href);
    return false;
  });
});

// remove issue form parameters from url
if (location.search.match(/simplify/)) {
  history.replaceState({}, document.title, location.origin + location.pathname);
}
