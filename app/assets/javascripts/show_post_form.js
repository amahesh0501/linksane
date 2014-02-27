$(document).ready(function () {
  $('#post_form').hide();
  $('#show_post_form').on('click', function(){
    $('#post_form').slideToggle();
  });
});