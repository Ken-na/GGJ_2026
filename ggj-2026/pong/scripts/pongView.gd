extends Node3D
class_name PongView

@export var topOfField:float
@export var fieldWidth:float

var padels:Array[Padel]

var ballSpawner:BallSpawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is BallSpawner:
			ballSpawner = child

func addPadel(padel:Padel) -> void:
	padels.append(padel)

func startSpawning(spawningScript:SpawningScript) -> void:
	ballSpawner.startSpawning(spawningScript)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
