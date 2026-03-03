class_name StateWalk extends State

@export var move_speed: float = 100.0
@onready var idle: State = $"../Idle"


# 定义角色进入该状态时调用的函数
func Enter() -> void:
	player.UpdateAnimation("walk")

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle

	player.velocity = player.direction * move_speed

	if player.SetDirection():
		player.UpdateAnimation("walk")

	return null
