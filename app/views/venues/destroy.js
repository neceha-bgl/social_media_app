$('#delete-venue-<%= @venue.id %> a.close').click();
$('#delete-venue-<%= @venue.id %>').closest('tr').fadeOut();
