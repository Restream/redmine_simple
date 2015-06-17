function adaptiveHeight(a, min, max) {
  if ($(a).height() > min) {
    $(a).height(0);
    var newHeight = Math.min(Math.max($(a)[0].scrollHeight, min), max);
    $(a).height(newHeight);
    if (parseInt(a.style.height) > $(window).height() - 30) {
      $(document).scrollTop(parseInt(a.style.height));
    }
  }
}

$(document).ready(function() {
  var text_areas = '#issue_description,#issue_notes';
  $(text_areas).each(function() {
    adaptiveHeight(this, 200, 400);
  })
});
