@tool
class_name Train
extends Node3D

# --- exports ---
@export_category("Train Car Settings")
@export_range(1, 999, 1, "or_greater") var cars_amount : int :
	set(set_value):
		if cars_amount == set_value:
			return
		
		cars_amount = set_value
		
		delete_all_train_cars()
		
		# creating head
		var train_head : TrainCar = train_head_packed_scene.instantiate() as TrainCar
		train_head.set_name.call_deferred("TrainHead")
		_train_cars.append(train_head)
		
		# creating middle segments
		for i : int in range(1, cars_amount - 1):
			var segment : TrainCar = middle_segments_packed_scene.instantiate() as TrainCar
			segment.set_name.call_deferred("TrainCar" + str(i))
			_train_cars.append(segment)
		
		# creating caboose
		if cars_amount >= 2:
			var caboose : TrainCar = caboose_packed_scene.instantiate() as TrainCar
			caboose.set_name.call_deferred("Caboose")
			_train_cars.append(caboose)
		
		var attachment_point : Vector3 = Vector3.ZERO
		for train_car : TrainCar in _train_cars:
			train_car.position = attachment_point
			add_child(train_car)
			train_car.owner = get_tree().edited_scene_root
			attachment_point = self.to_local(train_car.connect_point.get_global_position())

@export var train_head_packed_scene : PackedScene
@export var middle_segments_packed_scene : PackedScene
@export var caboose_packed_scene : PackedScene

@export_category("Important Values")
# --- node linkers ---
@export_subgroup("Node Linkers")

# --- resources ---
@export_subgroup("Resources")

# --- public variables ---

# --- private variables ---
@export_storage var _train_cars : Array[TrainCar]

# --- constants ---

# --- signals ---

# --- method overrides ---

# --- public methods ---
func delete_all_train_cars() -> void:
	for train_car in _train_cars:
		train_car.queue_free()
	_train_cars = []

func get_train_cars() -> Array[TrainCar]:
	return _train_cars

func get_train_head() -> TrainCar:
	return _train_cars[0]

func get_caboose() -> TrainCar:
	return _train_cars[-1]

# --- private methods ---
