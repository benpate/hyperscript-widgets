behavior Modal

	init
		add [@role="dialog"]
		set title to the first <h1,h2,h3/> in me
		if (title is not empty) then
			
			if title.id is empty  then 
				set title.id to "modal-title" 
			end

			set the @aria-labelledby to the title's id
		end

		focus() the first <[tabindex]/> in me

	on closeModal from window	
		if #modal is not empty then 
			add .closing to #modal
			settle
			remove #modal
		end
	
	on click(target)
		if the target's className is "modal-underlay" then
			trigger closeModal
		end

	on keydown[key=="Escape"]
		if #modal is not empty then 
			trigger closeModal
			halt the event
		end

	on keydown[key=="Tab"]
		set focusedElement to the first <:focus/>

		if event.shiftKey
			focus() the previous <[tabindex]/> from focusedElement with wrapping
		else
			focus() the next <[tabindex]/> from focusedElement with wrapping
		end

		halt the event
