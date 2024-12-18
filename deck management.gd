extends Node
#an array of nodes(cards). currently in the deck 
var Deck: Array
#an array of nodes(cards). currently in the hand
var Hand: Array
#a temporary holder for cards about to be added to the hand
var Hand_Mod: Array
#an array of nodes(cards). currently in the discard
var Discard: Array
#a temporary holder for cards about to be added to the discard
var To_be_removed: Array
#used to assign each card in the hand a unique z_index
var Card_positions: Array
#a simple scaler for the distance between cards in a hand
@export var card_distance_scaler: float
#the cards currently selected
var selected_group: Array
#used for instantiating the stated card into the scene
var card_template = preload("res://card_template.tscn")


#a temporary script for creating a deck of template cards to test with
func _ready():
	for i in 10:
		var card_instance = card_template.instantiate()
		card_instance.visible = false
		Deck.append(card_instance)
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
			Hand_Mod.append(Deck[0])
			Deck[0].visible = true
			Deck[0].set_process(true)
			Deck.remove_at(0)
			_hand_size_update()
		else:
			if Discard.size() == 0:
				pass
			Deck.append_array(Discard)
			Discard.clear()
			_shuffle()
			Hand_Mod.append(Deck[0])
			Deck[0].visible = true
			Deck[0].set_process(true)
			Deck.remove_at(0)
			_hand_size_update()


#takes all cards in the to_be_removed array and puts them into the discard
func _discard(To_be_removed):
	Discard.append_array(To_be_removed)
	for i in To_be_removed.size():
		Hand.erase(To_be_removed[i])
	for i in Discard.size():
		Discard[i].visible = false
		Discard[i].set_process(false)
		Discard[i].get_child(0).progress_ratio = 0
		Discard[i].state = Discard[i].state_not_hovered
	_hand_size_update()
	To_be_removed.clear()
	

#creates an array that gives the positions each card in your hand should sit
func _hand_size_update():
	Hand_Mod.append_array(Hand)
	Card_positions.clear()
	for i in Hand_Mod.size():
		Card_positions.append( 0.5 + (i - (Hand_Mod.size() - 1) / 2) * card_distance_scaler)
	for i in Hand_Mod.size():
			Hand_Mod[i].card_position = Card_positions[i]
			Hand_Mod[i].z_index = i
	Hand.clear()
	Hand.append_array(Hand_Mod)
	Hand_Mod.clear()


#receives the signal from the draw button and draws a single card
func _on_draw_pressed() -> void:
	_draw(1)


#receives the signal from the discard button and discards all selected cards
func _on_discard_pressed() -> void:
	if selected_group.size() > 0:
		_discard(selected_group)
