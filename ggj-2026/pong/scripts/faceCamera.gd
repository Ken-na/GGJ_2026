extends Node3D

@export var image:Texture
@export var spriteObject:Sprite3D

func _ready():
	if spriteObject:
		spriteObject.texture = image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#look_at(get_viewport().get_camera_3d().position)
	rotation.x = get_viewport().get_camera_3d().rotation.x
	pass
