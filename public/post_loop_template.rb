<div class="item widget-container fluid-height social-entry">
  <div class="widget-content padded">
    <div class="profile-info clearfix">
      <img width="50" height="50" class="social-avatar pull-left" src="images/avatar-female2.png" />
      <div class="profile-details">
        <% user = User.find(post.user_id) %>
        <a class="user-name" href="#"><%= user.name%></a>
        <p>
          <%formatted_date = post.created_at.strftime('%b %d %Y at %H:%M')%>
          <em><%=formatted_date%></em>
        </p>
      </div>
    </div>
    <p class="content">
      <%=post.description%>
    </p>
    <div class="btn btn-sm btn-default-outline">
      <i class="fa fa-thumbs-o-up"></i>
    </div>
  </div>
</div>



