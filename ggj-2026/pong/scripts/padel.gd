extends Node3D
class_name Padel

@export var area:Area3D

#feel free to unexport these, figured it might make tweaking them easier
@export var moveSpeed:float = 10;
@export var baseSize:float = 5;

var pongView:PongView

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitoring = true
	area.monitorable = true
	area.area_entered.connect(_area_entered)
	resizePadel(baseSize)

func _area_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithPadel(self)

func collidedWithEdge(side:int) -> void:
	pass

func _input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resizePadel(size:float) -> void:
	pass

#unsure if would be more conventional to have custom funcs above _ funcs, split to make sound nicer or smt l8r
func flipDirection():
	pass

func movePadel(movementVelocity: Vector3):
	position += movementVelocity * get_process_delta_time()
