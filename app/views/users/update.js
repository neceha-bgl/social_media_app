$('#edit-user-<%= @user.id %> a.close').click();
$('#edit-user-<%= @user.id %>').closest('tr').empty().after('<%= j render("user", user: @user)  %>');
$('#edit-user-<%= @user.id %>').closest('tr').fadeOut().fadeIn();
$('[data-behaviour~=datepicker]').datepicker({
    format: 'yyyy-mm-dd'
    });
$('[data-resource]').editable();
