extends Resource
class_name SpawningScript

@export var startingSpawnValues:Dictionary[SpawnRateChange.BallType, float]
@export var spawnRateChanges:Array[SpawnRateChange]

func getSpawnRate(ballType:SpawnRateChange.BallType, time:float) -> float:
	for spawnRateChange in spawnRateChanges:
		if spawnRateChange.type == ballType and spawnRateChange.time < time:
			return spawnRateChange.newRate
	
	if startingSpawnValues.get(ballType) != null:
		return startingSpawnValues[ballType]
	
	return 0
