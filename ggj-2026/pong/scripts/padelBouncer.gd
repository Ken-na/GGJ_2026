extends Padel

var spinningLeft:bool = false
var angle: float

var currDirection:int = 0
var directions:int = 8 
var dirChangeInterval:float = .25
var timeUntilDirChange:float 
var velocityDecaySpeed:float = 1 

var velocity:Vector3

var keyHeld:bool = false
var powerMulti:float = 1.5
var powerMultiSpeed:float = 1

@export var dirDisplayDistance:float = 3
@export var dirDisplay:Sprite3D

@export var leftSprite:Sprite3D
@export var middleSprite:Sprite3D
@export var rightSprite:Sprite3D
@export var iconSprite:Sprite3D

#this padel only moves when holding space, flips direction when press space, flips directions on bound.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	#changeDirOnFrequency()
	timeUntilDirChange = dirChangeInterval
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	leftSprite.modulate.a = alpha
	middleSprite.modulate.a = alpha
	rightSprite.modulate.a = alpha
	
	if !keyHeld:
		changeDirOnFrequency(delta)
		rotateDirDisplay()
	else:
		powerMulti = clamp(powerMulti + (delta * powerMultiSpeed), 1.5, 2.5)
	
	velocityDecay(delta)
	#print("bouncer velocity: ", velocity)
	movePadel(velocity * moveSpeed)
	checkEdgeCollisions()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("bouncer_paddle") and velocity.is_equal_approx(Vector3.ZERO):
		powerMulti = 1.5
		keyHeld = true
		
	if Input.is_action_just_released("bouncer_paddle") and keyHeld:
		velocity = dirDisplay.position.normalized() * powerMulti
		timeUntilDirChange = dirChangeInterval
		dirDisplay.hide()
		keyHeld = false

func changeDirOnFrequency(delta: float):
	timeUntilDirChange -= delta
	
	if timeUntilDirChange <= 0:
		currDirection = (currDirection + 1) % directions
		timeUntilDirChange = dirChangeInterval
	#while true:
	#	currDirection = (currDirection + 1) % directions
	#	await get_tree().create_timer(.25).timeout

func rotateDirDisplay():
	var angle:float = (360 / directions) * currDirection
	angle = deg_to_rad(angle)
	
	var newX: float = dirDisplayDistance * cos(angle)
	var newY: float = dirDisplayDistance * sin(angle)
	
	dirDisplay.position = Vector3(newX, newY, dirDisplay.position.z)

func velocityDecay(delta: float):
	velocity = velocity.move_toward(Vector3.ZERO, delta * velocityDecaySpeed)
	
	if velocity.is_equal_approx(Vector3.ZERO) and !dirDisplay.is_visible_in_tree():
		dirDisplay.show()

func resizePadel(size:float) -> void:
	var middleWidth:float = size - 2
	leftSprite.position.x = -middleWidth/2 - 0.5
	rightSprite.position.x = middleWidth/2 + 0.5
	middleSprite.scale.x = middleWidth
	area.scale.x = size

func checkEdgeCollisions() -> void:
	if position.x - area.scale.x/2 < -pongView.fieldWidth/2:
		velocity.x = 1
	elif position.x + area.scale.x/2 > pongView.fieldWidth/2:
		velocity.x = -1
		
	if position.y - area.scale.y/2 < -.5: #ganked from pongView
		velocity.y *= -1
	elif position.y + area.scale.y/2 > (pongView.topOfField -2): #bespoke decision
		velocity.y *= -1
		
	#print("padel.y: ", position.y, " | top: ", (pongView.topOfField + 0.5))
	
func getMoveDir():
	pass
