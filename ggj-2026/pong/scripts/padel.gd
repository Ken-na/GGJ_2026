extends Node3D
class_name Padel

@export var area:Area3D

#feel free to unexport these, figured it might make tweaking them easier
@export var moveSpeed:float = 10;
@export var boundsMinPlaceholder:Vector2 = Vector2(-15, -100) #placeholder, should be globally defined(?)
@export var boundsMaxPlaceholder:Vector2 = Vector2(15, 100) #placeholder, should be globally defined(?)

var movingRight:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitoring = true
	area.area_entered.connect(_area_entered)

func _area_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithPadel(self)

func _input(event: InputEvent) -> void:
	var currentVelocity:Vector3
	
	if Input.is_action_just_pressed("basic_paddle"):
		flipDirection()
	
	if Input.is_action_pressed("basic_paddle"):
		currentVelocity = Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed)
		position += currentVelocity * get_process_delta_time()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if position.x > boundsMaxPlaceholder.x or position.x < boundsMinPlaceholder.x:
		flipDirection()
		
	if position.y > boundsMaxPlaceholder.y or position.y < boundsMinPlaceholder.y:
		flipDirection()

#unsure if would be more conventional to have custom funcs above _ funcs, split to make sound nicer or smt l8r
func flipDirection():
	movingRight = !movingRight
