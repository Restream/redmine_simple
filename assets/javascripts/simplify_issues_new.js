// Simplify Issue New form

$(document).ready(function() {

  var simplifyActive = function() {
    return $('.simplify-off').hasClass('active');
  };

  var getNotSimpleElements = function() {
    var el = $('form#issue-form.new_issue div.box.tabular').children().not('#all_attributes');

    el = el
      .add($('#all_attributes').children()
        .not($('#issue_subject').parents('p:first'))
        .not($('#issue_description').parents('p:first'))
        .not($('#attributes')))

      .add($('#attributes p')
        .not($('#issue_assigned_to_id').parents('p:first')))

      .add($('#issue_description_and_toolbar').children()
        .not('.jstEditor'))

      .add($('.jstEditor').children()
        .not('#issue_description'));

    return el;
  };

  var updateIssueNewForm = function() {
    if (simplifyActive()) {
      getNotSimpleElements().hide();
    } else {
      getNotSimpleElements().show();
    }
  };

  var toggleSimplify = function() {
    if (simplifyActive()) {
      $('.simplify-off').removeClass('active');
      $('.simplify-on').addClass('active');
    } else {
      $('.simplify-on').removeClass('active');
      $('.simplify-off').addClass('active');
    };
    updateIssueNewForm();
  };

  $('.simplify-on,.simplify-off').on('click', toggleSimplify);

  updateIssueNewForm();
  // wait for other plugins add some stuff to form
  setTimeout(updateIssueNewForm, 50);
});
