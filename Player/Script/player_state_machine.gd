class_name PlayerStateMachine extends Node

#用于存储所有状态的数组
var states: Array[State]

#
var prev_state: State

#当前状态
var current_state: State

func _ready():
	#禁用所有子节点
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(delta: float):
	ChangeState(current_state.Process(delta))

func _physics_process(delta: float):
	ChangeState(current_state.Physics(delta))

func _unhandled_input(event: InputEvent):
	ChangeState(current_state.HandleInput(event))

func Initialize(_player: player) -> void:
	states = []

	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() > 0:
		State.player = _player  # Godot 4.6: 通过类名访问 static var
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

#专门处理状态切换
func ChangeState(new_state: State) -> void:
	if new_state == null || new_state == current_state:
		return
	if current_state:
		current_state.Exit()

	prev_state = current_state
	current_state = new_state
	current_state.Enter()
