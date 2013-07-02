$('#new_venue a.close').click();
$('#venues table').prepend('<%= j render("venue", venue: @venue)  %>');
$('#venues table tr:eq(1)').fadeOut().fadeIn();
$('[data-resource]').editable();
