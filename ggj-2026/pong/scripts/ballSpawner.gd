extends Node
class_name BallSpawner

@export var ballTypes:Array[PackedScene]

var pongView:PongView

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pongView = get_parent()

var mSpawningScript:SpawningScript

var started:bool = false
func startSpawning(spawningScript:SpawningScript) -> void:
	started = true
	mSpawningScript = spawningScript

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		pass
