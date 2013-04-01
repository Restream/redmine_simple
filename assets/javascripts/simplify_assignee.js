// Make text input with autocomplete from select input for assignee
function simplifyAssigneeField(url) {
  $(document).ready(function() {

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
          source: url,
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
}
