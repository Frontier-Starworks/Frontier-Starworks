/datum/disease/cold9
	name = "The Cold"
	max_stages = 3
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Common Cold Anti-bodies & Spaceacillin"
	cures = list(/datum/reagent/medicine/spaceacillin)
	agent = "ICE9-rhinovirus"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "If left untreated the subject will slow, as if partly frozen."
	severity = DISEASE_SEVERITY_HARMFUL

/datum/disease/cold9/stage_act()
	..()
	switch(stage)
		if(2)
			affected_mob.adjust_bodytemperature(-10)
			if(prob(1) && prob(10))
				to_chat(affected_mob, span_notice("You feel better."))
				cure()
				return
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, span_danger("Your throat feels sore."))
			if(prob(5))
				to_chat(affected_mob, span_danger("You feel stiff."))
		if(3)
			affected_mob.adjust_bodytemperature(-3)
			if(prob(1))
				affected_mob.emote("sneeze")
			if(prob(1))
				affected_mob.emote("cough")
			if(prob(1))
				to_chat(affected_mob, span_danger("Your throat feels sore."))
			if(prob(10))
				to_chat(affected_mob, span_danger("You feel stiff."))
