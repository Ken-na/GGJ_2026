extends Node2D
var moveSpeed:float = 100 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity:Vector2
	velocity = Vector2.UP.rotated(rotation) * moveSpeed
	position += velocity * delta
