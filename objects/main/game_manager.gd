extends Node
class_name game_manager

static var health: int = 400
static var money: int = 0
static var wave: int = 1

static func add_health(num: int):
	health += num
	
static func add_money(num: int):
	money += num
	
static func add_wave(num: int):
	wave += num
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
