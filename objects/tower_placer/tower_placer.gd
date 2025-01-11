extends Node
class_name TowerPlacer

@onready var camera: Camera3D = $"../Camera3D"
@onready var cube = $"../MeshInstance3D2"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos: Vector2i = get_viewport().get_mouse_position()
	var ray_length: int = 8000
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	
	var space = get_viewport().get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	print(raycast_result)
	
