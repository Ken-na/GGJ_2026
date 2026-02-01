extends Resource
class_name SpawnRateChange

enum BallType {
	test,
	sine,
	curve
}

@export var type:BallType
@export var time:float
@export var newRate:float
