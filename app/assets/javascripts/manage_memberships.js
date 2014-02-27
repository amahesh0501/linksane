$(function(){

  $('.revoke a').on('click', function(e){
    e.preventDefault()
    $.ajax({
      type: 'POST',
      url: '/memberships/revoke',
      data: {
        user_id: e.target.dataset.userId,
        wall_id: e.target.dataset.wallId
      }
    }).success(function(response){
      $('p.reinstate').append("lala")
      $('p.revoke[data-user-id='+response.user_id + ']').remove()
    })
  })


  $('.reinstate a').on('click', function(e){
    e.preventDefault()
    $.ajax({
      type: 'POST',
      url: '/memberships/reinstate',
      data: {
        user_id: e.target.dataset.userId,
        wall_id: e.target.dataset.wallId
      }
    }).success(function(response){
      $('p.revoke').append($('p.revoke[data-user-id='+response.user_id + ']'))
      $('p.reinstate[data-user-id='+response.user_id + ']').remove()
    })
  })

});