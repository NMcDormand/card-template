extends Node
var select_delin: Array


func delin():
	if select_delin.size() == 2:
		if select_delin[0].z_index > select_delin[1].z_index:
			select_delin[0].state_update(true)
			select_delin[1].state_update(false)
			select_delin.remove_at(1)
		elif select_delin[0].z_index < select_delin[1].z_index:
			select_delin[1].state_update(true)
			select_delin[0].state_update(false)
			select_delin.remove_at(0)
	elif select_delin.size():
		select_delin[0].state_update(true)
