class_name StateIdle extends State

@onready var walk: State = $"../Walk"


# 定义角色进入该状态时调用的函数
func Enter() -> void:
	player.UpdateAnimation("idle")

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
