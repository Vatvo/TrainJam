extends Node
class_name TowerPlacer

@onready var camera: Camera3D = $"../Camera3D"

@export var current_tower: Tower
var isPlacing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isPlacing:
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
		
		if !raycast_result.is_empty():
			current_tower.position = raycast_result["position"]

func _input(event):
	if event is InputEventMouseButton:
		isPlacing = false
		current_tower = null
		
func begin_placement(tower: PackedScene):
	current_tower = tower.instantiate()
	add_child(current_tower)
	isPlacing = true
	
func place_tower():
	isPlacing = false

func abort_placement():
	current_tower.queue_free()
	isPlacing = false
	
	
