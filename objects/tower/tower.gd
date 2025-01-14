extends Node
class_name Tower

@export var tower_health: int = 1
@export var tower_damage: int = -1
@export var mesh_object: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func do_damage(damage: int) -> void:
	tower_health += damage
	if tower_health < 1:
		queue_free()

func _on_area_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is TrainCar:
		print(area)
		area.do_damage(tower_damage)
		do_damage(-1)
