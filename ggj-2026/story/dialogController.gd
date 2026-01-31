extends Node3D
class_name DialogController

@export var label: Label3D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func showSpeech(lineToShow: WritingLine):
	label.text = lineToShow.scriptLine

func showThought(lineToShow: WritingLine):
	label.text = lineToShow.thoughtLine
	
func markPhaseFail():
	pass

func markPhaseSuccess():
	pass
