class_name TrainCarPathFollow
extends PathFollow3D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var remote_transform : RemoteTransform3D

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---

# --- private variables ---
var _start_progress_ratio = 0.0

# --- constants ---

# --- signals ---

# --- method overrides ---

# --- public methods ---
func start(train_car : TrainCar, path : TrackPath, speed : float) -> void:
	path.add_child(self)
	# call deferred so the train cars dont flash on screen for a frame
	remote_transform.set_remote_node.call_deferred(train_car.get_path())
	
	var next_path : TrackPath = await follow_path(path, speed)
	while next_path != null:
		await transfer_paths(next_path, speed)
		next_path = await follow_path(next_path, speed)
	if is_instance_valid(train_car):
		train_car.queue_free()

## returns the connected path
func follow_path(path : TrackPath, speed : float) -> TrackPath:
	reparent(path)
	progress_ratio = _start_progress_ratio
	var curve : Curve3D = path.get_curve()
	var total_length : float = curve.get_baked_length()
	var total_time : float = total_length / speed * (1.0 - progress_ratio)
	
	var follow_tween : Tween = create_tween()
	follow_tween.tween_property(
		self,
		"progress_ratio",
		1.0,
		total_time
	)
	
	await follow_tween.finished
	
	return path.get_next_path()

func transfer_paths(to_path : TrackPath, with_speed : float) -> void:
	var end_position : Vector3 = to_path.curve.get_closest_point(global_position)
	var start_quat : Quaternion = quaternion
	var end_quat : Quaternion = Quaternion(to_path.curve.sample_baked_with_rotation(0.0, false, true).basis)
	var total_time : float = (global_position - end_position).length() / with_speed
	
	_start_progress_ratio = to_path.curve.get_closest_offset(global_position) / to_path.curve.get_baked_length()
	
	var transfer_tween : Tween = create_tween()
	transfer_tween.tween_property(
		self,
		"global_position",
		end_position,
		total_time
	)
	transfer_tween.parallel().tween_method(
		_slerp_to_rotation.bind(end_quat),
		0.0,
		1.0,
		total_time
	)
	
	await transfer_tween.finished

# --- private methods ---
func _slerp_to_rotation(weight : float, to : Quaternion) -> void:
	quaternion = quaternion.slerp(to, weight)
