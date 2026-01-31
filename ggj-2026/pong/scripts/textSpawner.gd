extends Node
class_name TextSpawner

@export var dialogController: DialogController

func startSpawning(spawningScript:WritingLineChange, sceneManager:CombineSceneManager):
	print("enter text start spawning")
	var currentScriptLineIndex: int = 0
	
	while currentScriptLineIndex < spawningScript.scriptLines.size():
		dialogController.showText(spawningScript.scriptLines[currentScriptLineIndex])
		await get_tree().create_timer(spawningScript.scriptLines[currentScriptLineIndex].duration).timeout
		print("resume, showing: ", spawningScript.scriptLines[currentScriptLineIndex].scriptLine)
		currentScriptLineIndex += 1
	
	dialogController.hideText()
	sceneManager.resumeStory()
