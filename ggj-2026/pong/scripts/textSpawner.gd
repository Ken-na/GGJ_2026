extends Node
class_name TextSpawner

@export var dialogController: DialogController
var nextPhaseSuccessDialog:bool = true

func startSpawning(spawningScript:WritingLineChange):
	print("enter text start spawning")
	var currentScriptLineIndex: int = 0
	var timer: float = 0;
	
	while currentScriptLineIndex < spawningScript.scriptLines.size():
		
		if nextPhaseSuccessDialog: 
			dialogController.showThought(spawningScript.scriptLines[currentScriptLineIndex])
		else:
			dialogController.showText(spawningScript.scriptLines[currentScriptLineIndex])
		
		currentScriptLineIndex += 1
		if currentScriptLineIndex >= spawningScript.scriptLines.size():
			break
			
		var delay: float = spawningScript.scriptLines[currentScriptLineIndex].time - timer;
		print("await: ", delay, " Showing: ", spawningScript.scriptLines[currentScriptLineIndex].scriptLine, " | ", get_timestamp())
		await get_tree().create_timer(delay).timeout
		timer = spawningScript.scriptLines[currentScriptLineIndex].time
		
		print("resume")

# STOLEN Function to get a formatted timestamp with milliseconds
func get_timestamp() -> String:
	# Get current system time
	var now = Time.get_datetime_dict_from_system()
	var ms = Time.get_ticks_msec() % 1000  # Milliseconds part

	# Format: YYYY-MM-DD HH:MM:SS.mmm
	return "%04d-%02d-%02d %02d:%02d:%02d.%03d" % [
		now.year, now.month, now.day,
		now.hour, now.minute, now.second, ms
	]
