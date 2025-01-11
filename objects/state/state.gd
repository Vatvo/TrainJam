class_name State
extends Node

signal transitioned(new_state_name: StringName)

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Update(delta: float) -> void:
	pass

func PhysicsUpdate(delta: float) -> void:
	pass

func PlayAnimation() -> void:
	pass

func PauseAnimation() -> void:
	pass
