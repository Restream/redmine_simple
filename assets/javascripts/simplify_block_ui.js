/* Block page while updating issue form */

$.blockUI.defaults.message = '';
$.blockUI.defaults.overlayCSS = '0';

var issueFormBlocker = {
  enabled: false,
  enable:  function() { this.enabled = true; },
  disable: function() { this.enabled = false; },
  block:   function() {
    if (this.enabled) { $.blockUI(); }
  }
};

$(document).ajaxStart(function() {
  issueFormBlocker.block();
});

$(document).ajaxStop(function() {
  issueFormBlocker.disable();
  $.unblockUI();
});

var origUpdateIssueFrom = updateIssueFrom;
updateIssueFrom = function(url) {
  issueFormBlocker.enable();
  origUpdateIssueFrom(url);
};

// Just redraw select2
var origReplaceIssueFormWith = replaceIssueFormWith;
replaceIssueFormWith = function(url) {
  origReplaceIssueFormWith(url);
  simplifyAssignee();
  simplifyWatchers();
};
