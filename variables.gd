extends Node
var select_delin: Array

func _process(delta: float) -> void:
	if select_delin.size() == 2:
		select_delin.sort_custom(_compare)
		select_delin.remove_at(0)
	if select_delin.size():
		select_delin[0].state_update()

func _compare(a, b):
	if a.z_index < b.z_index:
		return -1  # a comes before b
	elif a.z_index > b.z_index:
		return 1   # a comes after b
	else:
		return 0   # a and b are equal
