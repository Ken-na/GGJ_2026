extends Node3D
class_name Ball

@export var area:Area3D
@export var velocity:Vector2 = Vector2(0, 0)
@export var verticalSpeed:float = 1.0
@export var horizontalSpeed:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitorable = true

func collidedWithPadel(padel:Padel) -> void:
	velocity.y = -velocity.y
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move based on velocity
	transform.origin.x += velocity.x*delta * horizontalSpeed;
	transform.origin.y += velocity.y*delta * verticalSpeed;
