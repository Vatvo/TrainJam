class_name Main
extends Node3D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")
@export var train_packed_scene : PackedScene

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if (event as InputEventKey).is_pressed() and (event as InputEventKey).keycode == KEY_T:
			var train : Train = train_packed_scene.instantiate()
			add_child(train)
			train.cars_amount = 3
			train.speed = 5
			await get_tree().process_frame
			train.start_on_follow_path.call_deferred($Paths/MainPath1)

# --- public methods ---

# --- private methods ---
