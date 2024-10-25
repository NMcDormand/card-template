extends Path2D
@export var speed = 1
@export var card_position: float
var card_position_in_hand: int


func _process(delta):
	if card_position > get_child(0).progress_ratio:
		get_child(0).progress_ratio = get_child(0).progress_ratio + speed * delta

