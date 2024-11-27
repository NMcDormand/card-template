extends Node
var select_delin: Array

# determines which of 2 cards should be in the hovered state.
func delin():
	if select_delin.size() == 2:
		if select_delin[0].z_index > select_delin[1].z_index:
			select_delin[0].state_update(true)
			select_delin[1].state_update(false)
		elif select_delin[0].z_index < select_delin[1].z_index:
			select_delin[1].state_update(true)
			select_delin[0].state_update(false)
	elif select_delin.size() == 1:
		select_delin[0].state_update(true)
