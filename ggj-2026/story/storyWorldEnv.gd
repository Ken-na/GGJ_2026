extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a WorldEnvironment node
	var world_environment = WorldEnvironment.new()
	add_child(world_environment)
	
	# Create an Environment resource
	var environment = Environment.new()
	world_environment.environment = environment
	
	# Set ambient light properties
	environment.ambient_light_color = Color(0.5, 0.5, 0.5) # Grey color
	environment.ambient_light_energy = 1.0 # Intensity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
