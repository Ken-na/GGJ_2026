extends Resource
class_name WritingLine

enum Speaker {
	player,
	npcOne
}

@export var type:Speaker
@export var duration:float
@export var scriptLine:String
