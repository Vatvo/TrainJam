class_name MouseScannerManager
extends Node3D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var ray_cast : RayCast3D

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _physics_process(delta: float) -> void:
	var mouse_pos: Vector2i = get_viewport().get_mouse_position()
	var ray_length: int = 8000
	var camera : Camera3D = get_viewport().get_camera_3d()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	
	ray_cast.global_position = from
	ray_cast.target_position = to - from
	
	ray_cast.force_raycast_update()
	
	if ray_cast.is_colliding():
		if ray_cast.get_collider() is Lever:
			print("gotem")

# --- public methods ---

# --- private methods ---
