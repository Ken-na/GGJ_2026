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

var acceptedBall:SpawnRateChange.BallType = -1

const sfxGrow = preload("res://Audio/Mask SFX - Dud Sfx 2.ogg")

const sfxShrink = preload("res://Audio/Mask SFX 8.ogg")

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
	
	for child in get_children():
		if child is Padel:
			addPadel(child)

func _left_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithEdge(-1)
		
func _right_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().collidedWithEdge(1)
		
func _top_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().goneOffTop()
		
func _bottom_entered(body:Area3D) -> void:
	if body.get_parent() is Ball:
		body.get_parent().goneOffBottom()
		if body.get_parent().ballTypeID == acceptedBall:
			shrinkPanels(body.get_parent())
		else:
			growPanels(body.get_parent())

func growPanels(ball:Ball):
	print("grow hit")
	play_sfx(sfxGrow)
	for padel:Padel in padels:
		if padel.colliderBallID == ball.ballTypeID:
			if padel.enabled == false:
				padel.enablePadel()
			padel.incrementSize()

func shrinkPanels(ball:Ball):
	play_sfx(sfxShrink)
	for padel:Padel in padels:
		if padel.colliderBallID == ball.ballTypeID:
			padel.decrementSize()

func addPadel(padel:Padel) -> void:
	padels.append(padel)
	padel.pongView = self

func addBall(ball:Ball) -> void:
	balls.append(ball)
	ball.initialPosition(Vector4(-fieldWidth/2 + 2, topOfField - 1.5, fieldWidth/2 - 2, topOfField - 1.5))
	ballContainer.add_child(ball)

func startSpawning(spawningScript:SpawningScript) -> void:
	ballSpawner.startSpawning(spawningScript, self, acceptedBall)

func startLevel(level:Level):
	if level.anyPositiveBalls:
		acceptedBall = level.positiveBallType
	else:
		acceptedBall = -1
	startSpawning(level.spawnScript)

func setRunning(running:bool):
	if running:
		process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_sfx(sound: AudioStream, parent: Node = get_tree().current_scene,
 		pitch_range: Vector2 = Vector2(1.0,1.0), volume_db: float = 1):
	if sound != null and parent != null:
		var stream_player = AudioStreamPlayer.new()

		stream_player.stream = sound
		stream_player.pitch_scale = randf_range(pitch_range.x, pitch_range.y)
		stream_player.volume_db = volume_db

		parent.add_child(stream_player)
		stream_player.play()
