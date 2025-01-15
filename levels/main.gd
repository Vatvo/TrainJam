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
			return
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
			train.cars_amount = 2
			train.speed = 5
			await get_tree().process_frame
			train.start_on_follow_path.call_deferred($Paths/MainPath1)

func _process(delta: float) -> void:
	$CanvasLayer/Heart/HealthLabel.text = str(game_manager.health)
	if game_manager.health <= 0:
		$CanvasLayer/LoseScreen.visible = true
		get_tree().paused = true
# --- public methods ---
func spawn_good_train():
	spawn_train(good_train_packed_scene)

func spawn_bad_train():
	spawn_train(bad_train_packed_scene)

func spawn_train(train_packed_scene : PackedScene):
	var train : Train = train_packed_scene.instantiate()
	# so the trains aren't immediately visible
	train.position = Vector3.ONE * 999.0
	add_child(train)
	train.cars_amount = 3
	train.speed = 5
	await get_tree().process_frame
	train.start_on_follow_path.call_deferred($Paths/MainPath1)

func decrease_timers():
	for node : Node in $Timers.get_children():
		if node is RandomizableTimer:
			(node as RandomizableTimer).min *= 0.8
			(node as RandomizableTimer).max *= 0.8
# --- private methods ---
