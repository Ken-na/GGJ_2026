extends Resource
class_name SpawnRateChange

enum BallType {
	test,
	sineBall,
	repeatBall,
	avoidantBall
	
}

@export var type:BallType
@export var time:float
@export var newRate:float
