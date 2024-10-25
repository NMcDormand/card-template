extends Node
var Deck: Array
var Hand: Array
var Discard: Array
var To_be_removed: Array
var Card_positions: Array
@export var card_distance_scaler: float
@export var Hand_size: int

var card_template = preload("res://card_template.tscn")


func _ready():
	for i in Hand_size:
		Hand.append(0)
	_hand_size_update()
	for i in Hand_size:
		var card_instance = card_template.instantiate()
		card_instance.card_position = Card_positions[i]
		card_instance.position.y = -1654.81
		get_child(0).add_child(card_instance)



#shuffles the Deck. 
func _shuffle():
	Deck.shuffle()


#draws a number of cards from your deck = to draw_count and adds it you your hand
#if your deck is empty it shuffles your discard into your deck then draws a card
#if both deck and discard are empty then it stops trying and passes
func _draw(draw_count):
	for i in draw_count:
		if Deck.size() > 0:
			Hand.append(Deck[0])
			Deck.remove_at(0)
			call(_hand_size_update())
		else:
			if Discard.size() == 0:
				pass
			Deck.append_array(Discard)
			Discard.clear()
			call(_shuffle())
			Hand.append(Deck[0])
			Deck.remove_at(0)
			call(_hand_size_update())


#takes all cards in the to_be_removed array and puts them into the discard
func _discard(To_be_removed):
	Discard.append_array(To_be_removed)
	call(_hand_size_update())

#creates an array that gives the positions each card in your hand should sit
func _hand_size_update():
	for i in Hand.size():
		Card_positions.append( 0.5 + (i - (Hand_size - 1) / 2) * card_distance_scaler)
