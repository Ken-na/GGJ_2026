extends Node3D
class_name CombineSceneManager

@export var cam: Camera3D
@export var storyView: Node3D
@export var pongView: Node3D

@export var cameraPosPong: Vector3
@export var cameraPosStory: Vector3
var cameraMoveSpeed: float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pongView.process_mode = Node.PROCESS_MODE_DISABLED	
	
	print("cam pos: ", cam.position)
	cam.position = cameraPosStory
	print("cam pos (modified): ", cam.position)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func startPong():
	pass

func moveCameraToPong():
	var movePerc: float = 0
	
	while movePerc < 1:
		cam.position = cameraPosStory.lerp((cameraPosPong), movePerc)
		movePerc += get_process_delta_time() * cameraMoveSpeed
		await get_tree().process_frame
		

func resumeStory():
	pongView.process_mode = Node.PROCESS_MODE_DISABLED	
	await get_tree().create_timer(.5).timeout
	
	#wait then move
	await moveCameraToStory()
	
func moveCameraToStory():
	var movePerc: float = 0
	
	while movePerc < 1:
		cam.position = cameraPosPong.lerp((cameraPosStory), movePerc)
		movePerc += get_process_delta_time() * cameraMoveSpeed
		await get_tree().process_frame
	
func finishedStoryWalking():
	#introduction bump 
	await get_tree().create_timer(1.0).timeout
	#wait then move
	await moveCameraToPong()
	#move is finished
	
	#resume calculations
	pongView.process_mode = Node.PROCESS_MODE_ALWAYS
	pass
