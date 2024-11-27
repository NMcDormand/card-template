extends Path2D
#a scaler for how fast the cards should move to their position in your hand
@export var speed = 1
#used to determine position in the hand
@export var card_position: float
#used to determine its z index
var card_position_in_hand: int
#used for teh variable script delin function
var hovered: bool
#used to determine whether the card is selected
var selected = false
#used by the process function to act as a state machine
var state: Callable = state_undefined



#moves the card to the correct position in the hand then calls its state function
func _process(delta):
	if card_position > get_child(0).progress_ratio:
		get_child(0).progress_ratio = get_child(0).progress_ratio + speed * delta
	state.call(delta)

#along with mouse exited this is used to determine if the card should be in the hovered state
func _on_area_2d_mouse_entered() -> void:
	$"/root/Variables".select_delin.append(self)
	$"/root/Variables".delin()

#along with mouse entered this is used to determine if the card should be in the hovered state
func _on_area_2d_mouse_exited() -> void:
	$"/root/Variables".select_delin.erase(self)
	$"/root/Variables".delin()
	state = state_not_hovered

#selects the card in the hovered state
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.pressed:
			if state == state_hovered:
				state = state_selected
				get_parent().get_parent().selected_group.append(self)

#state: the mouse is over this card so it highlights and raises up slightly to show the player that this is the card they are about to select 
func state_hovered(delta):
	if get_child(0).get_child(0).get_child(0).progress_ratio < 0.5:
		get_child(0).get_child(0).get_child(0).progress_ratio = get_child(0).get_child(0).get_child(0).progress_ratio + speed*3 * delta
	modulate.r = 0.9
	modulate.g = 0.9
	modulate.b = 0.9

#state: the standard state undos the state of the hovered state
func state_not_hovered(delta):
	if get_child(0).get_child(0).get_child(0).progress_ratio > 0:
		get_child(0).get_child(0).get_child(0).progress_ratio = get_child(0).get_child(0).get_child(0).progress_ratio - speed*3 * delta
	modulate.r = 0.8
	modulate.g = 0.8
	modulate.b = 0.8

#state: this card has neen selected and will raise up to signify as such
func state_selected(delta):
	get_child(0).get_child(0).get_child(0).progress_ratio = 1

#the state the card starts in when added to the scene. does nothing
func state_undefined(delta):
	pass

#called by the delin function in the global script to delineate which of 2 cards should be hovered when the mouse is hovering over multiple
func state_update(bool):
	if bool == true:
		state = state_hovered
	if bool == false:
		state = state_not_hovered
