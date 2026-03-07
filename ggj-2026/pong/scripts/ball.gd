extends Node3D
class_name Ball

@export var area:Area3D
@export var velocity:Vector2 = Vector2(0, 0)
@export var verticalSpeed:float = 1.0
@export var horizontalSpeed:float = 1.0
@export var ballTypeID:SpawnRateChange.BallType
@export var sparks:GPUParticles3D


@export var spriteToGlow:Sprite3D

const sfxBounce = preload("res://Audio/Mask SFX Bounce.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.monitorable = true

func collidedWithPadel(padel:Padel) -> void:
	velocity.y = -velocity.y
	sparks.emitting = true
	play_sfx(sfxBounce)	
	print ("bounce")

func collidedWithEdge(side:int) -> void:
	velocity.x = -velocity.x

func addGlow():
	spriteToGlow.visible = true
	pass

func goneOffTop() -> void:
	queue_free()
	
func goneOffBottom() -> void:
	queue_free()

func initialPosition(bounds:Vector4) -> Vector2:
	var randPos:Vector2 = Vector2(	bounds.x + randf()*(bounds.z - bounds.x),
									bounds.y + randf()*(bounds.w - bounds.y))
	transform.origin.x = randPos.x
	transform.origin.y = randPos.y
	
	velocity.x = -3 + 6*randf()
	velocity.y = -5
	return randPos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move based on velocity
	transform.origin.x += velocity.x*delta * horizontalSpeed;
	transform.origin.y += velocity.y*delta * verticalSpeed;

func play_sfx(sound: AudioStream, parent: Node = get_tree().current_scene,
 		pitch_range: Vector2 = Vector2(1.0,1.0), volume_db: float = 1):
	if sound != null and parent != null:
		var stream_player = AudioStreamPlayer.new()

		stream_player.stream = sound
		stream_player.pitch_scale = randf_range(pitch_range.x, pitch_range.y)
		stream_player.volume_db = volume_db

		parent.add_child(stream_player)
		stream_player.play()
