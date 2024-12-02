extends Node2D
var hover_position: Vector2i
var hover_tile_atlas: Vector2i
var hover_position_new: Vector2i
var state: Callable = selectable


func _process(delta: float) -> void:
	state.call()


func selectable():
	hover_position = get_child(0).local_to_map(self.to_local(get_global_mouse_position()))
	hover_tile_atlas = get_child(0).get_cell_atlas_coords(hover_position_new)
	if hover_position != hover_position_new:
		if hover_tile_atlas == Vector2i(2,1):
			get_child(0).set_cell(hover_position_new,0, Vector2i(0,0) , 0)
		elif hover_tile_atlas == Vector2i(3,1):
			get_child(0).set_cell(hover_position_new,0, Vector2i(1,0) , 0)
	elif hover_position == hover_position_new:
		if hover_tile_atlas == Vector2i(0,0):
			get_child(0).set_cell(hover_position_new,0, Vector2i(2,1) , 0)
		elif hover_tile_atlas == Vector2i(1,0):
			get_child(0).set_cell(hover_position_new,0, Vector2i(3,1) , 0)
	hover_position_new = hover_position


func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if hover_tile_atlas != Vector2i(-1, -1):
				pass
