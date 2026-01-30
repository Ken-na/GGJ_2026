extends Node2D
@export var bulletSceneFab:PackedScene
@export var tank:Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("base hello world")

"""
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_key_pressed(KEY_SPACE):
"""

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var spawnBullet = bulletSceneFab.instantiate()
		spawnBullet.position = Vector2(tank.position.x, tank.position.y)
		spawnBullet.rotation = tank.rotation
		add_child(spawnBullet)
		
		print("tank: ", tank.position)
		print("bulletspawn: ", spawnBullet.position)
		
