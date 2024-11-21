extends Node
var select_delin: Array


func delin():
	if select_delin.size() == 2:
		if select_delin[0].z_index > select_delin[1].z_index:
			print("0 greater then 1")
			select_delin[0].state_update(true)
			select_delin[1].state_update(false)
		elif select_delin[0].z_index < select_delin[1].z_index:
			print("1 greater then 0")
			select_delin[1].state_update(true)
			select_delin[0].state_update(false)
	elif select_delin.size() == 1:
		print("size 1")
		select_delin[0].state_update(true)
