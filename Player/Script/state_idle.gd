class_name StateIdle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


# 定义角色进入该状态时调用的函数
func Enter() -> void:
	player.SetDirection()
	player.UpdateAnimation("idle")

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return 
