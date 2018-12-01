extends Area2D

func _integrate_forces(state):
	if (state.get_contact_count() > 0):
    	state.get_contact_local_pos(0)