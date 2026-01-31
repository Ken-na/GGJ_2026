extends Ball

var hasBounced:bool
@export var acceleration:float = 0.9

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	verticalSpeed = verticalSpeed - (verticalSpeed * acceleration)
	super._process(delta)
	pass
