$ ->
	$.fn.editable.defaults.mode = 'inline'
	$('.email-input').editable({
		url: '',
		type: 'text'
		placeholder: 'please input email'
	})

$ ->
	$.fn.editable.defaults.mode = 'inline'
	$('.region-input').select2({
		data:[{id:0,text:'enhancement'},{id:1,text:'bug'},{id:2,text:'duplicate'},{id:3,text:'invalid'},{id:4,text:'wontfix'}]
	});
