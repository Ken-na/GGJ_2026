extends Resource
class_name WritingLine

enum Speaker {
	player,
	npcOne
}

@export var type:Speaker
@export var time:float
@export var scriptLine:String
@export var thoughtLine:String
