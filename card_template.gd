extends Path2D
@export var speed = 1
@export var card_position: float
var card_position_in_hand: int
var hovered: bool
var selected = false
var state: Callable = state_undefined




func _process(delta):
	if card_position > get_child(0).progress_ratio:
		get_child(0).progress_ratio = get_child(0).progress_ratio + speed * delta
	state.call(delta)


func _on_area_2d_mouse_entered() -> void:
	$"/root/Variables".select_delin.append(self)
	$"/root/Variables".delin()


func _on_area_2d_mouse_exited() -> void:
	$"/root/Variables".select_delin.erase(self)
	$"/root/Variables".delin()
	state = state_not_hovered

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			if state == state_hovered:
				state = state_selected
				get_parent().get_parent().selected_group.append(self)


func state_hovered(delta):
	if get_child(0).get_child(0).get_child(0).progress_ratio < 0.5:
		get_child(0).get_child(0).get_child(0).progress_ratio = get_child(0).get_child(0).get_child(0).progress_ratio + speed*3 * delta
	modulate.r = 0.9
	modulate.g = 0.9
	modulate.b = 0.9


func state_not_hovered(delta):
	if get_child(0).get_child(0).get_child(0).progress_ratio > 0:
		get_child(0).get_child(0).get_child(0).progress_ratio = get_child(0).get_child(0).get_child(0).progress_ratio - speed*3 * delta
	modulate.r = 0.8
	modulate.g = 0.8
	modulate.b = 0.8


func state_selected(delta):
	get_child(0).get_child(0).get_child(0).progress_ratio = 1


func state_undefined(delta):
	pass

func state_update(bool):
	if bool == true:
		state = state_hovered
		print(z_index," hover")
	if bool == false:
		state = state_not_hovered
		print(z_index," not hover")
