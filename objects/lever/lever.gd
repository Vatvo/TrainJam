class_name Lever
extends StaticBody3D

# --- exports ---
@export var linked_branching_path : BranchingTrackPath

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var animation_player : AnimationPlayer
@export var skeleton_animation_player : AnimationPlayer

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---
var flipped : bool = false : set = set_flipped

# --- private variables ---
var _mouse_hovered : bool = false

# --- constants ---

# --- signals ---

# --- method overrides ---
func _ready() -> void:
	skeleton_animation_player.current_animation = "ArmatureAction_001"
	skeleton_animation_player.pause()

func _input(event: InputEvent) -> void:
	if not _mouse_hovered: return
	if event is not InputEventMouseButton: return
	
	if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		toggle()

# --- public methods ---
func toggle() -> void:
	set_flipped(!flipped)

func set_flipped(set_value : bool) -> void:
	if set_value == flipped: return
	
	flipped = set_value
	if flipped:
		skeleton_animation_player.speed_scale = 1.0
		skeleton_animation_player.play()
	else:
		skeleton_animation_player.speed_scale = 1.0
		skeleton_animation_player.play_backwards()
	
	if linked_branching_path != null:
		linked_branching_path.set_path_switched(flipped)

# --- private methods ---
func _on_mouse_entered() -> void:
	_mouse_hovered = true
	animation_player.play("highlight")


func _on_mouse_exited() -> void:
	_mouse_hovered = false
	animation_player.play_backwards("highlight")
