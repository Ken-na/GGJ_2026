extends Sprite3D

@export var frameTime: float = 1
@export var timeUntilFrameChange: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeUntilFrameChange = frameTime
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeUntilFrameChange -= delta
	
	if timeUntilFrameChange <= 0:
		timeUntilFrameChange = frameTime
		frame = (frame + 1) % (hframes * vframes)
		
	pass
