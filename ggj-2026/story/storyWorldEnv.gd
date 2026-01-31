extends Node3D
class_name StoryWorldEnv

@export var sceneManager: CombineSceneManager 
@export var textSpawner: TextSpawner

@export var hallWayToMove: Node3D
@export var positions:Array[Vector3]
var currPosition:int = 0
var movingToNextScene:bool = false

#var moveTime: float = 3
var movePerc: float = 0
var moveSpeed: float = .25


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setupEnv()
	nextScene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if movingToNextScene:
		moveScene(delta)
	pass

func setupEnv():
	# Create a WorldEnvironment node
	var world_environment = WorldEnvironment.new()
	add_child(world_environment)
	
	# Create an Environment resource
	var environment = Environment.new()
	world_environment.environment = environment
	
	# Set ambient light properties
	environment.ambient_light_color = Color(0.5, 0.5, 0.5) # Grey color
	environment.ambient_light_energy = 1.0 # Intensity

func nextScene():
	currPosition = clamp(currPosition + 1, 0, positions.size())
	movingToNextScene = true
	movePerc = 0

func moveScene(delta:float):
	if currPosition == 0 or currPosition == positions.size():
		return
	
	movePerc += delta * moveSpeed
	hallWayToMove.position = positions[currPosition - 1].lerp(positions[currPosition], movePerc)
	
	if movePerc >= 1: 
		movingToNextScene = false
		sceneManager.finishedStoryWalking()
		

func startSpawningText(script: WritingLineChange, sceneManager:CombineSceneManager):
	textSpawner.startSpawning(script, sceneManager)
	
#func showText(lineToShow: WritingLine):
#	dialogController.showText(lineToShow);
