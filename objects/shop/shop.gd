extends Node
class_name Shop

@export var cards: Array[Card] = []
@export var gold: int

func _ready():
	pass # Replace with function body.

func purchase_item(item: String, price: int):
	if gold > price:
		print("purchased " + item)
		gold -= price

func modulate_card(card: Card):
	if gold > card.price:
		card.modulate = Color(1, 1, 1, 1)
	else:
		card.modulate = Color(0.5, 0.5, 0.5, 1)
		
func _process(delta):
	gold += 1
	for child in self.get_children():
		if child.get_script() == Card:
			modulate_card(child)
			
