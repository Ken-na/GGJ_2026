extends Padel

var movingRight:bool = true

#this padel only moves when holding space, flips direction when press space, flips directions on bound.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	if !inBounds():
		flipDirection()

func _input(event: InputEvent) -> void:
	var currentVelocity:Vector3
	
	if Input.is_action_just_pressed("basic_paddle"):
		flipDirection()
	
	if Input.is_action_pressed("basic_paddle"):
		currentVelocity = Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed)
		position += currentVelocity * get_process_delta_time()

func flipDirection():
	super.flipDirection()
	movingRight = !movingRight
