@tool
class_name BranchingTrackPath
extends TrackPath

# --- exports ---
@export var alternate_path : TrackPath
@export var path_switch_animation_length : float = 0.3

# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---
var path_switched : bool = false : set = set_path_switched

# --- private variables ---
var _switch_tween : Tween = create_tween()

# --- constants ---

# --- signals ---

# --- method overrides ---
func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	curve.add_point(connected_path.curve.get_point_position(0), -connected_path.curve.get_point_out(0))

func get_next_path() -> TrackPath:
	if path_switched: return alternate_path
	return connected_path

# --- public methods ---
func switch_path():
	path_switched = !path_switched

func set_path_switched(set_value : bool) -> void:
	if path_switched == set_value: return
	
	path_switched = set_value
	
	_tween_switching_tracks()

# --- private methods ---
func _tween_switching_tracks() -> void:
	var start_val : float = 0.0
	if _switch_tween.is_running():
		# normalized time 0-1
		start_val = _switch_tween.get_total_elapsed_time() / path_switch_animation_length
	if !path_switched:
		start_val = 1.0 - start_val
	
	var end_val : float = 1.0 if path_switched else 0.0
	
	_switch_tween.kill()
	_switch_tween = create_tween()
	_switch_tween.tween_method(
		_lerp_switching_track,
		start_val,
		end_val,
		path_switch_animation_length * abs(start_val - end_val)
	)
	

func _lerp_switching_track(weight : float) -> void:
	var pos_1 : Vector3 = connected_path.curve.get_point_position(0)
	var pos_2 : Vector3 = alternate_path.curve.get_point_position(0)
	var in_1 : Vector3 = -connected_path.curve.get_point_out(0)
	var in_2 : Vector3 = -alternate_path.curve.get_point_out(0)
	
	var lerped_position : Vector3 = pos_1 + ((pos_2 - pos_1) * weight)
	var lerped_in : Vector3 = in_1 + ((in_2 - in_1) * weight)
	
	var last_point_index : int = curve.point_count - 1
	curve.set_point_position(last_point_index, lerped_position)
	curve.set_point_in(last_point_index, lerped_in)
