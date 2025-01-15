extends Node
class_name Shop

@export var cards: Array[Card] = []
@export var gold: int

@onready var tower_placer: TowerPlacer = $"../../TowerPlacer"

func purchase_item(item: String, price: int, tower: PackedScene):
	if gold > price:
		print("purchased " + item)
		gold -= price
		tower_placer.begin_placement(tower)

func modulate_card(card: Card):
	if gold > card.price:
		card.modulate = Color(1, 1, 1, 1)
	else:
		card.modulate = Color(0.5, 0.5, 0.5, 1)
		
func _process(delta):
	gold += 1
	$"../Dollar/MoneyLabel".text = str(gold)
	for child in self.get_children():
		if child.get_script() == Card:
			modulate_card(child)
			
