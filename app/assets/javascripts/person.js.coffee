jQuery ->
	$('#person_degrees_attributes_0_university_name').autocomplete
	  source: $('#person_degrees_attributes_0_university_name').data('universities-source')

jQuery ->
	$("#tabs").tabs().addClass('ui-tabs-vertical ui-helper-clearfix')
