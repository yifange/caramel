$ ->
	$.fn.editable.defaults.mode = 'inline'
	$('#username').editable({
		url: '',
		title: 'Enter username'
	})

$ ->
	$.fn.editable.defaults.mode = 'inline'
	$('#status').editable({
		value: 2,
		source: [
			{value: 1, text: 'Active'},
			{value: 2, text: 'Blocked'},
			{value: 3, text: 'Deleted'}
		]
	})
