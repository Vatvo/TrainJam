extends Node
class_name TowerPlacer

@onready var camera: Camera3D = $"../Camera3D"
@onready var validMaterial: StandardMaterial3D = preload("res://materials/validPlacement.tres")
@onready var invalidMaterial: StandardMaterial3D = preload("res://materials/invalidPlacement.tres")

@export var current_tower: Node
@export var valid_paths: Array[Path3D]
var isPlacing: bool = false
var validPlacement: Dictionary = {"valid": false, "position": Vector3(0,0,0)}

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
		ray_query.set_collision_mask(1)
		var raycast_result = space.intersect_ray(ray_query)
		
		if !raycast_result.is_empty():
			current_tower.position = raycast_result["position"]
		
		validPlacement = check_valid_placement()
		if validPlacement["valid"]:
			current_tower.mesh.material = validMaterial
			current_tower.position = validPlacement["position"]
			
		else:
			current_tower.mesh.material = invalidMaterial
		
		
			
func check_valid_placement():
	var res: bool = false
	for path in valid_paths:
		var closest_point = path.curve.get_closest_point(current_tower.position)
		if current_tower.position.distance_to(closest_point) < 0.5:
			return {"valid": true, "position": closest_point}
	return {"valid": false, "position": null}
	

func _input(event):
	if event is InputEventMouseButton && validPlacement["valid"]:
		isPlacing = false
		current_tower = null
		place_tower()
	elif event is InputEventMouseButton && !validPlacement["valid"] && isPlacing:
		abort_placement()
		
func begin_placement(tower: PackedScene):
	current_tower = tower.instantiate()
	add_child(current_tower)
	isPlacing = true
	
func place_tower():
	isPlacing = false
	current_tower = null

func abort_placement():
	current_tower.queue_free()
	isPlacing = false
	
	
