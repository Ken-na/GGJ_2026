extends Ball

@export var time:float

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	verticalSpeed = (sin(time*10)+1)/2
	horizontalSpeed = sin(time*5)
	super._process(delta)
	pass
