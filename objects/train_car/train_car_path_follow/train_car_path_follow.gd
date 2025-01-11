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

# --- constants ---

# --- signals ---

# --- method overrides ---

# --- public methods ---
func start(train_car : TrainCar, path : Path3D, speed : float) -> void:
	path.add_child(self)
	remote_transform.remote_path = train_car.get_path()
	
	var curve : Curve3D = path.get_curve()
	var total_length : float = curve.get_baked_length()
	var total_time : float = total_length / speed
	
	var follow_tween : Tween = create_tween()
	follow_tween.tween_property(
		self,
		"progress_ratio",
		1.0,
		total_time
	)

# --- private methods ---
