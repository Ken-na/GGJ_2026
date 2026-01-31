extends Padel

#var movingTo:int = 3
var movingToXPos:float
var moving:bool = false

@export var leftSprite:Sprite3D
@export var middleSprite:Sprite3D
@export var rightSprite:Sprite3D
@export var iconSprite:Sprite3D

#this padel only moves when holding space, flips direction when press space, flips directions on bound.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	if !moving:
		return

	print(abs(abs(position.x) - abs(movingToXPos)), " < ", moveSpeed)
	print(position.x, " - ", movingToXPos)
	
	var diff:float = 0
	if position.x > movingToXPos:
		diff = abs(position.x - movingToXPos)
	else:
		diff = abs(movingToXPos - position.x)
	
	if diff < (moveSpeed * delta): #is_equal_approx(position.x, movingToXPos):
		moving = false
		return
		
	if position.x > movingToXPos:
		movePadel(-Vector3.RIGHT * moveSpeed)
	elif position.x < movingToXPos:
		movePadel(Vector3.RIGHT * moveSpeed)
	


func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("see_paddle_1"):
		movingToXPos = getXAxisFloatFromNumber(1)
		moving = true
	
	if Input.is_action_just_pressed("see_paddle_2"):
		movingToXPos = getXAxisFloatFromNumber(2)
		moving = true
	
	if Input.is_action_just_pressed("see_paddle_3"):
		movingToXPos = getXAxisFloatFromNumber(3)
		moving = true
	
	if Input.is_action_just_pressed("see_paddle_4"):
		movingToXPos = getXAxisFloatFromNumber(4)
		moving = true
	
	if Input.is_action_just_pressed("see_paddle_5"):
		movingToXPos = getXAxisFloatFromNumber(5)
		moving = true

func resizePadel(size:float) -> void:
	var middleWidth:float = size - 2
	leftSprite.position.x = -middleWidth/2 - 0.5
	rightSprite.position.x = middleWidth/2 + 0.5
	middleSprite.scale.x = middleWidth
	area.scale.x = size

func getXAxisFloatFromNumber(movingTo:int) -> float:
	match movingTo:
		1:
			return -pongView.fieldWidth/2 + area.scale.x/2
		2:
			return -pongView.fieldWidth/4
		3:
			return 0
		4:
			return +pongView.fieldWidth/4
		5:
			return +pongView.fieldWidth/2 - area.scale.x/2
		_:
			return 0
	
func getMoveDir():
	pass
