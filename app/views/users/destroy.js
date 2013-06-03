$('#delete-user-<%= @user.id %> a.close').click();
$('#delete-user-<%= @user.id %>').closest('tr').fadeOut();
