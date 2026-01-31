extends Node
class_name BallSpawner

@export var ballTypes:Dictionary[SpawnRateChange.BallType, PackedScene]
var ballSpawnProgress:Dictionary[SpawnRateChange.BallType, float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for type in SpawnRateChange.BallType.size():
		ballSpawnProgress[type] = 0

var mSpawningScript:SpawningScript

var started:bool = false
var timePassed:float = 0
var pongViewRef:PongView
func startSpawning(spawningScript:SpawningScript, pongView:PongView) -> void:
	started = true
	timePassed = 0
	pongViewRef = pongView
	mSpawningScript = spawningScript

func spawnBall(type:SpawnRateChange.BallType) -> void:
	var newBall:Ball = ballTypes[type].instantiate()
	pongViewRef.addBall(newBall)

func _process(delta: float) -> void:
	timePassed = timePassed + delta
	if started:
		for type:SpawnRateChange.BallType in SpawnRateChange.BallType.size():
			var spawnRate = mSpawningScript.getSpawnRate(type, timePassed)
			ballSpawnProgress[type] = ballSpawnProgress[type] + delta*spawnRate*randf()
			
			while ballSpawnProgress[type] > 1:
				spawnBall(type)
				ballSpawnProgress[type] = ballSpawnProgress[type] - 1
