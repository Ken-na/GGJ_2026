extends Node
class_name TextSpawner

@export var dialogController: DialogController

func startSpawning(spawningScript:WritingLineChange):
	print("enter text start spawning")
	var currentScriptLineIndex: int = 0
	var timer: float = 0;
	
	while currentScriptLineIndex < spawningScript.scriptLines.size():
		var delay: float = spawningScript.scriptLines[currentScriptLineIndex].time - timer;
		print("await: ", delay)
		dialogController.showText(spawningScript.scriptLines[currentScriptLineIndex])
		await get_tree().create_timer(delay).timeout
		print("resume, showing: ", spawningScript.scriptLines[currentScriptLineIndex].scriptLine)
		timer = spawningScript.scriptLines[currentScriptLineIndex].time
		currentScriptLineIndex += 1
