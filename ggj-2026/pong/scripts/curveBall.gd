extends Ball

@export var path3DToFollow: Path3D
@export var pathFollowToFollow: PathFollow3D
var isFollowingCurve: bool = false
var curMoveDist: float = 0
var lastFramePos: Vector3 = Vector3.ZERO
var curveMoveSpeed: float = 0 #calculated on hit, keeps consistent speed for curve

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isFollowingCurve:
		getMoveAlongCurve()
	else:
		super._process(delta)
	pass

func collidedWithPadel(padel:Padel) -> void:
	rollNewCurve(padel)

#probably needs to prioritize moving away from object, but test fo now
func rollNewCurve(padel:Padel):
	
	if isFollowingCurve: #TEMP TEMP TEMP
		return
		
	var rangeX:float = 5
	var rangeY:float = 5
	
	if padel.position.x > position.x:
		rangeX *= -1
		
	if padel.position.y > position.y:
		rangeY *= -1
		
	var curvePos:Vector3 = Vector3(randi_range(rangeX * .5, rangeX), randi_range(rangeY * .5, rangeY), 0)
	var outPos:Vector3 = Vector3(randi_range(rangeX * .5, rangeX * 1.5), randi_range(rangeY * .5, rangeY * 1.5), 0)
	
	path3DToFollow.curve.set_point_position(1, curvePos) 
	path3DToFollow.curve.set_point_out(1, outPos)
	
	isFollowingCurve = true
	curMoveDist = 0
	curveMoveSpeed = velocity.length()

func getMoveAlongCurve():
	var delta: float = get_process_delta_time()
	var targetPos:Vector3
	#var curveMoveSpeed:float = velocity.length()
	curMoveDist += curveMoveSpeed * delta
	
	if(curMoveDist > path3DToFollow.curve.get_baked_length()):
		print("getMoveAlongCurve FINISHED")
		isFollowingCurve = false
		return
		
	pathFollowToFollow.set_progress(curMoveDist)
	targetPos = pathFollowToFollow.position - lastFramePos
	#velocity = Vector2(position.x - targetPos.x, position.y - targetPos.y)
	velocity = Vector2(targetPos.x, targetPos.y).normalized() * curveMoveSpeed
	
	super._process(delta)
	
	lastFramePos = pathFollowToFollow.position
	#targetPos = pathFollowToFollow.sample_baked(curMoveDist)
	#position = curveToFollow.
	#
	#position = targetPos
