extends Node3D
class_name Padel

@export var area:Area3D

#feel free to unexport these, figured it might make tweaking them easier
@export var moveSpeed:float = 10;
@export var boundsMinPlaceholder:Vector2 = Vector2(-15, -100) #placeholder, should be globally defined(?)
@export var boundsMaxPlaceholder:Vector2 = Vector2(15, 100) #placeholder, should be globally defined(?)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitoring = true
	area.area_entered.connect(_area_entered)

func _area_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithPadel(self)

func _input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#unsure if would be more conventional to have custom funcs above _ funcs, split to make sound nicer or smt l8r
func flipDirection():
	pass

#will probably be moved global
func inBounds() -> bool:
	if (position.x > boundsMaxPlaceholder.x or position.x < boundsMinPlaceholder.x) or (position.y > boundsMaxPlaceholder.y or position.y < boundsMinPlaceholder.y):
		return false
		
	return true
	
