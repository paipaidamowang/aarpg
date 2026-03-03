class_name State extends Node

#用于存储玩家实例引用
static var player: player

# 定义角色进入该状态时调用的函数
func Enter() -> void:
	pass

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	pass

func Process(_delta: float) -> State:
	return null

func Physics(_delta: float) -> State:
	return null

func HandleInput(_event: InputEvent) -> State:
	return null
