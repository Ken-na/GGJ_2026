extends Sprite2D

var speed:int = 400
var angularSpeed:float = PI
var currentRot:float = 0 
var rotSpeed:float = 50 
var moveSpeed:float = 100 

func _init():
	print("hello world? ")
	
func _process(delta):
	var velocity:Vector2
	
	if Input.is_key_pressed(KEY_S):
		velocity = -Vector2.UP.rotated(rotation) * moveSpeed
		
	if Input.is_key_pressed(KEY_W):
		velocity = Vector2.UP.rotated(rotation) * moveSpeed
		
	if Input.is_key_pressed(KEY_A):
		currentRot -= rotSpeed * delta
		
	if Input.is_key_pressed(KEY_D):
		currentRot += rotSpeed * delta
		
	rotation_degrees = currentRot
	position += velocity * delta
	
	
"""
	#var velocity = Vector2.UP.rotated(rotation) * speed
	#position += velocity * delta
	#rotation += angular_speed * delta;
	#var buffer = 20
	var moveSpeed = 100

	#position = Vector2(randf_range(buffer, DisplayServer.screen_get_size().x - buffer),randf_range(buffer, DisplayServer.screen_get_size().y - buffer))
	#position = Vector2(1000, 500)
	if Input.is_key_pressed(KEY_S):
		position.y += moveSpeed * delta
		
	if Input.is_key_pressed(KEY_W):
		position.y -= moveSpeed * delta
		
	if Input.is_key_pressed(KEY_A):
		position.x -= moveSpeed * delta
		
	if Input.is_key_pressed(KEY_D):
		position.x += moveSpeed * delta
	
	#print("pos: ", position)
"""
