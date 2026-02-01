extends Node3D
class_name DialogController

@export var nextLabel: Label3D 
@export var lastLabel: Label3D 
@export var bubble: Sprite3D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastLabel.modulate.a = 0
	nextLabel.modulate.a = 0
	bubble.modulate.a = 0

var hiding:bool = false
var showingNext:bool = false;
var progress:float = 0.0
var bubbleShowProgress:float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if showingNext:
		progress = min(progress + delta, 1)
		bubbleShowProgress = min(bubbleShowProgress + delta, 1)
		nextLabel.modulate.a = progress
		lastLabel.modulate.a = 1 - progress
		bubble.modulate.a = bubbleShowProgress
	elif hiding:
		progress = min(progress + delta, 1)
		bubbleShowProgress = max(bubbleShowProgress - delta, 0)
		nextLabel.modulate.a = 1 - progress
		lastLabel.modulate.a = 1 - progress
		bubble.modulate.a = bubbleShowProgress

func showText(lineToShow: WritingLine):
	lastLabel.text = nextLabel.text
	nextLabel.text = lineToShow.scriptLine
	lastLabel.modulate.a = progress
	nextLabel.modulate.a = 1 - progress
	
	showingNext = true
	hiding = false
	progress = 1 - progress

func hideText():
	hiding = true
	showingNext = false
	progress = 1 - progress
