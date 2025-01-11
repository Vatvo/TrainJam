extends Button
class_name Card

@export var affordable_image: CompressedTexture2D
@export var unafforable_image: CompressedTexture2D
@export var price: int

@onready var shop: Shop = $".."
#var tower: Tower

func _ready():
	shop.cards.append(self)
	self.pressed.connect(self._button_pressed)

func _button_pressed():
	shop.purchase_item(name, price)
