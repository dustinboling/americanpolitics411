jQuery ->
	$('.university-list').live('focus', (event) ->
		$(this).autocomplete
	  	source: $('.university-list').data('universities-source')
	)
	$('.person-list').live('focus', (event) ->
		$(this).autocomplete
	  	source: $('.person-list').data('people-source')

	$('.organization-list').live('focus', (event) ->
		$(this).autocomplete
	  	source: $('.organization-list').data('organizations-source')
	)
	$('.slug-list').live('focus', (event) ->
		$(this).autocomplete
	  	source: $('.slug-list').data('slug-source')
	)
	
	$("#tabs").tabs().addClass('ui-tabs-vertical ui-helper-clearfix')
	$('#topbar').dropdown()