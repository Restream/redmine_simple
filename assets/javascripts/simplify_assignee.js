function simplifyAssigneeField(url) {
  $(document).ready(function() {

    // replace select to hidden input in order to select2 can works with ajax
    var assigned_to_id = $("#issue_assigned_to_id option[selected]:first").val();
    var assigned_to_text = $("#issue_assigned_to_id option[selected]:first").text();
    $("#issue_assigned_to_id")
        .replaceWith('<input id="issue_assigned_to_id" type="hidden" name="issue[assigned_to_id]"></input>')
        .val(assigned_to_id);

    $("#issue_assigned_to_id").select2({
      initSelection: function(element, callback) {
        var data = {
          id: assigned_to_id,
          text: assigned_to_text
        };
        callback(data);
      },
      width: '60%',
      allowClear: true,
      placeholder: ' ',
      ajax: {
        url: url,
        data: function(term, page) {
          return {
            term: term
          };
        },
        results: function(data, page) {
          return jQuery.parseJSON(data);
        }
      }
    });
    $("#issue_assigned_to_id").select2('data', {
        id: assigned_to_id,
        text: assigned_to_text
    });
  });
}

//    if ($('#issue_assigned_to_id_ac').length < 1) {
////      $('#issue_assigned_to_id').hide()
////          .after('<input id="issue_assigned_to_id_ac">');
//    }

//    $('#issue_assigned_to_id_ac')
//        .val($('#issue_assigned_to_id option[selected]').text())
//        .change(function() {
//          $('#issue_assigned_to_id').val('');
//        });
//
//    $('#issue_assigned_to_id_ac')
//        .autocomplete({
//          delay: 0,
//          minLength: 0,
//          source: url,
//          focus: function(event, ui) {
//            $('#issue_assigned_to_id_ac' ).val(ui.item.label);
//            return false;
//          },
//          select: function(event, ui) {
//            $('#issue_assigned_to_id_ac').val(ui.item.label);
//            $('#issue_assigned_to_id').val(ui.item.value);
//            $(this).data('closing', true);
//            return false;
//          },
//          close: function()
//          {
//            // avoid double-pop-up issue
//            setTimeout(function() {
//              $('#issue_assigned_to_id_ac').data('closing', false);
//            }, 300);
//          }
//        })
//        .bind('click', function() {
//          if (!$(this).data('closing')) {
//            $(this).autocomplete("search");
//          }
//        });



// select2 requires this way of setting width
// Make text input with autocomplete from select input for assignee
