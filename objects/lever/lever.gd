class_name Lever
extends StaticBody3D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")
@export var animation_player : AnimationPlayer

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---
var flipped : bool = true : set = set_flipped

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _ready() -> void:
	animation_player.current_animation = "ArmatureAction_001"
	animation_player.pause()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_G and event.pressed:
			toggle()

# --- public methods ---
func toggle() -> void:
	set_flipped(!flipped)

func set_flipped(set_value : bool) -> void:
	if set_value == flipped: return
	
	flipped = set_value
	if flipped:
		animation_player.speed_scale = 1.0
		animation_player.play_backwards()
	else:
		animation_player.speed_scale = 1.0
		animation_player.play()

# --- private methods ---
