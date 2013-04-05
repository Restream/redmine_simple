function reloadIssueNewFrom(url) {
  $('#issue-form').attr('action', url).trigger('submit');
}

$(document).ready(function() {
  $('div#content').on('click', 'a.simplify-on, a.simplify-off', function() {
    reloadIssueNewFrom(this.href);
    return false;
  });
});
