extends Padel

var movingRight:bool = true
var moving:bool = false

#this padel only moves when holding space, flips direction when press space, flips directions on bound.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	if moving:
		movePadel(Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed))
	if !inBounds():
		flipDirection()

func _input(event: InputEvent) -> void:
	var currentVelocity:Vector3
	
	if Input.is_action_just_pressed("basic_paddle"):
		flipDirection()
		moving = true
	
	if Input.is_action_just_released("basic_paddle"):
		moving = false
		
	#if Input.is_action_pressed("basic_paddle"):
	#	currentVelocity = Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed)

func flipDirection():
	super.flipDirection()
	movingRight = !movingRight
