class_name Main
extends Node3D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")
@export var good_train_packed_scene : PackedScene
@export var bad_train_packed_scene : PackedScene

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if (event as InputEventKey).is_pressed():
			var train_packed_scene : PackedScene = null
			match event.keycode:
				KEY_G:
					train_packed_scene = good_train_packed_scene
				KEY_B:
					train_packed_scene = bad_train_packed_scene
			
			if train_packed_scene == null:
				return
			
			var train : Train = train_packed_scene.instantiate()
			# so the trains aren't immediately visible
			train.position = Vector3.ONE * 999.0
			add_child(train)
			train.cars_amount = 3
			train.speed = 5
			await get_tree().process_frame
			train.start_on_follow_path.call_deferred($Paths/MainPath1)

# --- public methods ---

# --- private methods ---
