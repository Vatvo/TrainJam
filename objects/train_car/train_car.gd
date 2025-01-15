class_name TrainCar
extends Area3D

# --- exports ---
@export var good : bool = false

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var collision_shape : CollisionShape3D
@export var mesh : MeshInstance3D
@export var start_connect_point : Marker3D
@export var end_connect_point : Marker3D

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---
@export var car_health : int = 1

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		if good:
			game_manager.add_health(-50)
		else:
			game_manager.add_money(200)

# --- public methods ---
func get_length() -> float:
	var difference : Vector2 = Vector2(start_connect_point.position.x, start_connect_point.position.z) - Vector2(end_connect_point.position.x, end_connect_point.position.z)
	return difference.length()

func do_damage(damage: int) -> void:
	car_health += damage
	if car_health < 1:
		queue_free()
	
# --- private methods ---
