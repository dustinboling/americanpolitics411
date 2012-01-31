jQuery ->
	$('#person_degrees_attributes_0_university_name').autocomplete
	  source: $('#person_degrees_attributes_0_university_name').data('universities-source')
	$("#tabs").tabs().addClass('ui-tabs-vertical ui-helper-clearfix')
	$('#topbar').dropdown()