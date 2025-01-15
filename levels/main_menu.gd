class_name MainMenu
extends Node2D

# --- exports ---

# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")
@export var game_scene : PackedScene

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _ready():
	get_tree().paused = false

# --- public methods ---

# --- private methods ---




func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(game_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
