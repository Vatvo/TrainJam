extends Button
class_name Card

@export var tower: PackedScene
@export var price: int

@onready var shop: Shop = $".."


func _ready():
	shop.cards.append(self)
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	shop.purchase_item(name, price, tower)
