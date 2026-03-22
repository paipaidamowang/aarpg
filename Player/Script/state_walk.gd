class_name StateWalk extends State

@export var move_speed: float = 200.0
@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


# 定义角色进入该状态时调用的函数
func Enter() -> void:
	player.SetDirection()
	player.UpdateAnimation("walk")

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	# 方向变化时更新动画
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null

func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return 
