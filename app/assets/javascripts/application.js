// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {

  $('.vote').on('click', function(){
    var post_id = this.getAttribute('data-id')

    var request = $.ajax({
      type: "POST",
      url: "/votes",
      data: {id : post_id}
    });

    request.done(function(response){
      var post_id_to_update = response.post;
      var new_vote_count = response.votes;
      var selector = '.vote-count-' + post_id_to_update;
      $(selector).text(new_vote_count + ' votes');
    });
  })

  $("#tab1").show();
  $("li").click(function(){
    $("li").attr('class', '');
    $(".tab").hide();
    $(this).attr('class', 'active')
    var tab = $(this).find("a").attr('href')
    $(tab).show();
  });

  $('#post_form').hide();
  $('#show_post_form').on('click', function(){
    $('#post_form').slideToggle();
  });



});