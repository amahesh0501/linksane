var Vote = {
  init: function(){
    $('a.vote-post').on('ajax:success', this.updateVoteCount);
  },

  updateVoteCount: function(event, data){
    console.log(data)
    $(event.target).next()[0].innerHTML=data;
  }
}

$(function(){
  Vote.init();

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


})