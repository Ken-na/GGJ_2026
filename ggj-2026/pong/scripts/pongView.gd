extends Node3D
class_name PongView

@export var topOfField:float
@export var fieldWidth:float

@export var ballSpawner:BallSpawner
@export var ballContainer:Node3D

@export var testSpawningScript:SpawningScript

var padels:Array[Padel]
var balls:Array[Ball]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startSpawning(testSpawningScript)

func addPadel(padel:Padel) -> void:
	padels.append(padel)

func addBall(ball:Ball) -> void:
	balls.append(ball)
	ball.position(Vector4(-fieldWidth/2, -topOfField, fieldWidth/2, -topOfField))
	ballContainer.add_child(ball)

func startSpawning(spawningScript:SpawningScript) -> void:
	ballSpawner.startSpawning(spawningScript, self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
