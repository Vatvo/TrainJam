class_name RandomizableTimer
extends Timer

# --- exports ---
@export var min : float = 1.0
@export var max : float = 2.0

# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---

# --- private variables ---

# --- constants ---

# --- signals ---

# --- method overrides ---
func _ready():
	timeout.connect(_on_timeout)
	wait_time = randf_range(min, max)
	start()

# --- public methods ---

# --- private methods ---
func _on_timeout():
	wait_time = randf_range(min, max)
