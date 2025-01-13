@tool
class_name TrackPath
extends Path3D

# --- exports ---
## leave blank if this is the final path
@export var connected_path : TrackPath

@export_subgroup("Rail Settings")
@export var rail_mesh : Mesh
@export var distance_between_planks : float = 1.0 :
	set(set_value):
		distance_between_planks = set_value
		
		if Engine.is_editor_hint():
			_update_multimesh()

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var multimesh_instance : MultiMeshInstance3D

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---

# --- public methods ---
func get_next_path() -> TrackPath:
	return connected_path

# --- private methods ---
func _update_multimesh() -> void:
	multimesh_instance.multimesh = multimesh_instance.multimesh.duplicate()
	var multimesh : MultiMesh = multimesh_instance.multimesh
	
	var path_length : float = curve.get_baked_length()
	var count : int = floor(path_length / distance_between_planks)
	
	multimesh.instance_count = count
	var offset = distance_between_planks / 2.0
	
	for i : int in range(count):
		var curve_distance : float = offset + distance_between_planks * i
		
		var mesh_transform : Transform3D = curve.sample_baked_with_rotation(curve_distance, false, true)
		multimesh.set_instance_transform(i, mesh_transform)

func _on_curve_changed() -> void:
	_update_multimesh()
