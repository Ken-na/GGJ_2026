extends Node3D
class_name Padel

@export var area:Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitoring = true
	area.area_entered.connect(_area_entered)

func _area_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithPadel(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
