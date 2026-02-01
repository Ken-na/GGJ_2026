extends Node3D
class_name CombineSceneManager

@export var cam: Camera3D
@export var storyView: StoryWorldEnv
@export var pongView: Node3D
@export var fullScript: WritingScript

@export var cameraPosPong: Vector3
@export var cameraRotationPong: float
@export var cameraPosStory: Vector3
@export var cameraRotationStory: float
var cameraMoveSpeed: float = 1

#var moveTime: float = 3
var movePerc: float = 0
var moveSpeed: float = .25

var currentScriptIndex: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pongView.setRunning(false)
	Audio_Player.play_music_level()
	
	print("cam pos: ", cam.position)
	cam.position = cameraPosStory
	print("cam pos (modified): ", cam.position)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func moveCameraToPong():
	Audio_Player.play_pong_music()
	var movePerc: float = 0
	
	while movePerc < 1:
		cam.position = cameraPosStory.lerp((cameraPosPong), movePerc)
		cam.rotation.x = lerp(cameraRotationStory, cameraRotationPong, movePerc)
		movePerc += get_process_delta_time() * cameraMoveSpeed
		await get_tree().process_frame
		
 
func resumeStory():
	Audio_Player.play_music_level()
	await get_tree().create_timer(.5).timeout
	pongView.setRunning(false)
	
	#wait then move
	await moveCameraToStory()
	storyView.nextScene()
	
func moveCameraToStory():
	var movePerc: float = 0
	
	while movePerc < 1:
		cam.position = cameraPosPong.lerp((cameraPosStory), movePerc)
		cam.rotation.x = lerp(cameraRotationPong, cameraRotationStory, movePerc)
		movePerc += get_process_delta_time() * cameraMoveSpeed
		await get_tree().process_frame
	
func finishedStoryWalking():
	
	#storyView.showText(fullScript.writingLineChanges[currentScriptIndex].scriptLines[currentScriptLineIndex])
	
	#WAIT FOR CLICK??
	#storyView.showText(fullScript[currentScriptIndex][currentScriptIndexLine])
	#introduction bump 
	await get_tree().create_timer(1.0).timeout
	#wait then move
	storyView.startSpawningText(fullScript.writingLineChanges[currentScriptIndex], self)
	if fullScript.writingLineChanges[currentScriptIndex].level != null:
		pongView.startLevel(fullScript.writingLineChanges[currentScriptIndex].level)
	await moveCameraToPong()
	#move is finished
	
	#resume calculations
	pongView.setRunning(true)
	#ballSpawner.startSpawning(spawningScript, self) #TODO MOVE THIS HERE!
	pass
