extends Node3D
class_name Padel

@export var area:Area3D

#feel free to unexport these, figured it might make tweaking them easier
@export var moveSpeed:float = 10;
@export var baseSize:float = 5;
@export var growIncrement:float = 0.1

@export var colliderBallID:SpawnRateChange.BallType

@export var startEnabled:bool = false
var enabled:bool = false

var currentSize:float
var growingToSize:float

var pongView:PongView

var alpha:float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentSize = baseSize
	growingToSize = baseSize
	area.area_entered.connect(_area_entered)
	resizePadel(baseSize)
	
	if startEnabled:
		alpha = 1
		enablePadel()
	else:
		visible = false
		area.monitoring = false

func enablePadel():
	print("PADEL ENABLED")
	if enabled == false:
		enabled = true
		visible = true
		area.monitoring = true

func _area_entered(body:Area3D) -> void:
	if body.get_parent() is Ball and body.get_parent().ballTypeID == colliderBallID:
		body.get_parent().collidedWithPadel(self)

func collidedWithEdge(side:int) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enabled:
		alpha = min(alpha + delta, 1)
		
	if growingToSize > currentSize:
		currentSize = min(currentSize + delta*(0.1 + growingToSize - currentSize), growingToSize)
		resizePadel(currentSize)
	elif growingToSize < currentSize:
		currentSize = max(currentSize + delta*(growingToSize - currentSize - 0.1), growingToSize)
		resizePadel(currentSize)

func incrementSize():
	growToSize(growingToSize + growIncrement)
	
func decrementSize():
	growToSize(growingToSize - growIncrement)

func growToSize(size:float):
	growingToSize = max(size, baseSize)

func resizePadel(size:float) -> void:
	pass

#unsure if would be more conventional to have custom funcs above _ funcs, split to make sound nicer or smt l8r
func flipDirection():
	pass

func movePadel(movementVelocity: Vector3):
	position += movementVelocity * get_process_delta_time()
