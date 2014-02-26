$(function(){
  $(document).on('ajax:success', '#leave-group' ,function (event, data) {
    console.log(data)
    $('.wall-link-' + data.wall_id).hide();

  });
})