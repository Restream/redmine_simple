// Make text input with autocomplete from select input for assignee

$(document).ready(function() {

  var assignee = [];

  $('#issue_assigned_to_id > option').each(function(i, o) {
    if (o.label) {
      assignee.push({
        label: o.label,
        value: o.value
      });
    }
  });


  $('#issue_assigned_to_id optgroup').each(function(i, optgroup) {
    $(optgroup).children('option').each(function(i, o) {
      assignee.push({
        label: optgroup.label + ': ' + o.label,
        value: o.value
      });
    });
  });

  $('#issue_assigned_to_id').hide()
    .after('<input id="issue_assigned_to_id_ac" size="60">');

  $('#issue_assigned_to_id_ac')
    .val($('#issue_assigned_to_id option[selected]').text())
    .change(function() {
      $('#issue_assigned_to_id').val('');
    });


  $('#issue_assigned_to_id_ac')
    .autocomplete({
      delay: 0,
      minLength: 0,
      source: assignee,
      focus: function(event, ui) {
        $('#issue_assigned_to_id_ac' ).val(ui.item.label);
        return false;
      },
      select: function(event, ui) {
        $('#issue_assigned_to_id_ac').val(ui.item.label);
        $('#issue_assigned_to_id').val(ui.item.value);
        return false;
      }
    });

});
