/mob/living/simple_animal/pet/gondola/gondolapod
	name = "gondola"
	real_name = "gondola"
	desc = "The silent walker. This one seems to be part of a delivery agency."
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	faction = list("gondola")
	turns_per_move = 10
	icon = 'icons/obj/supplypods.dmi'
	icon_state = "gondola"
	icon_living = "gondola"
	pixel_x = -16//2x2 sprite
	base_pixel_x = -16
	pixel_y = -5
	base_pixel_y = -5
	layer = TABLE_LAYER//so that deliveries dont appear underneath it
	//Gondolas aren't affected by cold.
	atmos_requirements = IMMUNE_ATMOS_REQS
	minbodytemp = 0
	maxbodytemp = 1500
	maxHealth = 200
	health = 200
	del_on_death = TRUE
	var/opened = FALSE
	var/obj/structure/closet/supplypod/centcompod/linked_pod

/mob/living/simple_animal/pet/gondola/gondolapod/Initialize(mapload, pod)
	if(!pod)
		stack_trace("Gondola pod created with no pod")
		return INITIALIZE_HINT_QDEL
	linked_pod = pod
	name = linked_pod.name
	. = ..()

/mob/living/simple_animal/pet/gondola/gondolapod/update_overlays()
	. = ..()
	if(opened)
		. += "[icon_state]_open"
	return ..()

/mob/living/simple_animal/pet/gondola/gondolapod/verb/deliver()
	set name = "Release Contents"
	set category = "Gondola"
	set desc = "Release any contents stored within your vast belly."
	linked_pod.open_pod(src, forced = TRUE)

/mob/living/simple_animal/pet/gondola/gondolapod/examine(mob/user)
	. = ..()
	if (contents.len)
		. += span_notice("It looks like it hasn't made its delivery yet.</b>")
	else
		. += span_notice("It looks like it has already made its delivery.</b>")

/mob/living/simple_animal/pet/gondola/gondolapod/verb/check()
	set name = "Count Contents"
	set category = "Gondola"
	set desc = "Take a deep look inside youself, and count up what's inside"
	var/total = contents.len
	if (total)
		to_chat(src, span_notice("You detect [total] object\s within your incredibly vast belly."))
	else
		to_chat(src, span_notice("A closer look inside yourself reveals... nothing."))

/mob/living/simple_animal/pet/gondola/gondolapod/setOpened()
	opened = TRUE
	update_appearance()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, setClosed)), 50)

/mob/living/simple_animal/pet/gondola/gondolapod/setClosed()
	opened = FALSE
	update_appearance()

/mob/living/simple_animal/pet/gondola/gondolapod/death()
	QDEL_NULL(linked_pod) //Will cause the open() proc for the linked supplypod to be called with the "broken" parameter set to true, meaning that it will dump its contents on death
	qdel(src)
	..()
