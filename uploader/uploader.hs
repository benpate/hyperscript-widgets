behavior Uploader(url, accept)

init
	add .uploader to me

	put 
	`<form hx-post="${url}" 
		hx-trigger="change" 
		hx-swap="none" 
		hx-encoding="multipart/form-data" 
		script="on htmx:afterRequest trigger upload:success"
		hidden="true">
		<input type="file" id="manual-upload" name="file" accept="${accept}">
	</form>` 
	at the start of me

	set element form to the first <form/> in me
	set element input to the first <input[type="file"]/> in me

	call htmx.process(element form)
	
on dragenter
	halt the event
	add .highlight

on dragover
	halt the event
	add .highlight

on dragleave
	halt the event
	remove .highlight

on drop(dataTransfer)
	halt the event
	remove .highlight
	set element input.files to dataTransfer.files
    trigger change on element input

on htmx:xhr:progress
	log event
end
