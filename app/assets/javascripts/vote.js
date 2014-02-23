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
})