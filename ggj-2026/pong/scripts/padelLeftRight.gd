extends Padel

var movingRight:bool = true
var moving:bool = false

@export var leftSprite:Sprite3D
@export var middleSprite:Sprite3D
@export var rightSprite:Sprite3D

#this padel only moves when holding space, flips direction when press space, flips directions on bound.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	if moving:
		movePadel(Vector3.RIGHT * (moveSpeed if movingRight else -moveSpeed))
		#movePadel(Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed)) #normalized errors, may bring back later

func collidedWithEdge(side:int) -> void:
	movingRight = side == -1

func _input(event: InputEvent) -> void:
	var currentVelocity:Vector3
	
	if Input.is_action_just_pressed("basic_paddle"):
		flipDirection()
		moving = true
	
	if Input.is_action_just_released("basic_paddle"):
		moving = false
		
	#if Input.is_action_pressed("basic_paddle"):
	#	currentVelocity = Vector3.RIGHT.rotated(rotation.normalized(), rotation.x) * (moveSpeed if movingRight else -moveSpeed)

func resizePadel(size:float) -> void:
	var middleWidth:float = size - 2
	leftSprite.position.x = -middleWidth/2 - 0.5
	rightSprite.position.x = middleWidth/2 + 0.5
	middleSprite.scale.x = middleWidth
	area.scale.x = size

func flipDirection():
	super.flipDirection()
	movingRight = !movingRight
