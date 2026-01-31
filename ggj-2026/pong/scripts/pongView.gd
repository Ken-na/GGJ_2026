extends Node3D
class_name PongView

@export var topOfField:float
@export var fieldWidth:float

@export var background:Sprite3D

@export var ballSpawner:BallSpawner
@export var ballContainer:Node3D

@export var testSpawningScript:SpawningScript

@export var leftCollidor:Area3D
@export var rightCollidor:Area3D
@export var topCollidor:Area3D
@export var botCollidor:Area3D

var padels:Array[Padel]
var balls:Array[Ball]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.position.y = topOfField/2
	background.scale.x = fieldWidth
	background.scale.y = abs(topOfField)
	
	leftCollidor.position.x = -fieldWidth/2 - 0.5
	leftCollidor.position.y = topOfField/2
	leftCollidor.scale.y = abs(topOfField)
	leftCollidor.monitoring = true
	leftCollidor.area_entered.connect(_left_entered)
	
	rightCollidor.position.x = fieldWidth/2 + 0.5
	rightCollidor.position.y = topOfField/2
	rightCollidor.scale.y = abs(topOfField)
	rightCollidor.monitoring = true
	rightCollidor.area_entered.connect(_right_entered)
	
	topCollidor.position.y = topOfField + 0.5
	topCollidor.scale.x = fieldWidth + 2
	topCollidor.monitoring = true
	topCollidor.area_entered.connect(_top_entered)
	
	botCollidor.position.y = -0.5
	botCollidor.scale.x = fieldWidth + 2
	botCollidor.monitoring = true
	botCollidor.area_entered.connect(_bottom_entered)
	
	startSpawning(testSpawningScript)

func _left_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithEdge(-1)
	elif body.get_parent() is Padel:
		body.get_parent().collidedWithEdge(-1)
		
func _right_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithEdge(1)
	elif body.get_parent() is Padel:
		body.get_parent().collidedWithEdge(1)
		
func _top_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().goneOffTop()
		
func _bottom_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().goneOffBottom()
		
func addPadel(padel:Padel) -> void:
	padels.append(padel)

func addBall(ball:Ball) -> void:
	balls.append(ball)
	ball.initialPosition(Vector4(-fieldWidth/2, topOfField - 1.5, fieldWidth/2, topOfField - 1.5))
	ballContainer.add_child(ball)

func startSpawning(spawningScript:SpawningScript) -> void:
	ballSpawner.startSpawning(spawningScript, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
