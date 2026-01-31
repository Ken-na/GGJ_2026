extends Node3D
class_name Ball

@export var area:Area3D
var velocity:Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitorable = true

func collidedWithPadel(padel:Padel) -> void:
	velocity.y = -velocity.y

func position(bounds:Vector4) -> Vector2:
	var randPos:Vector2 = Vector2(	bounds.x + randf()*(bounds.z - bounds.x),
									bounds.y + randf()*(bounds.w - bounds.y))
	transform.origin.x = randPos.x
	transform.origin.y = randPos.y
	
	velocity.x = -3 + 6*randf()
	velocity.y = -5
	return randPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move based on velocity
	transform.origin.x += velocity.x*delta;
	transform.origin.y += velocity.y*delta;
