class_name StateAttack extends State

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox


@export var attack_sound : AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 0.5

@onready var attack: StateAttack = $"."
@onready var audio: AudioStreamPlayer2D = $"../../Node2D/AudioStreamPlayer2D"


var _finished: bool = false

# 定义角色进入该状态时调用的函数
func Enter() -> void:
	_finished = false
	player.UpdateAnimation("attack")
	player.PlayAttackEffect()
	
	# 攻击时调hurt_box=true, 延迟攻击
	hurt_box.monitoring = true
	await get_tree().create_timer( 0.075 ).timeout
	
	# 攻击音乐播放
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.5 , 1.0)
	audio.play()
	# 监听动画播放完毕信号
	player.animation_player.animation_finished.connect(_on_animation_finished)

# 定义角色退出该状态时调用的函数
func Exit() -> void:
	# 断开信号，防止重复连接
	if player.animation_player.animation_finished.is_connected(_on_animation_finished):
		player.animation_player.animation_finished.disconnect(_on_animation_finished)
	# 攻击结束时
	hurt_box.monitoring = false

func _on_animation_finished(_anim_name: StringName) -> void:
	_finished = true

func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if _finished:
		if player.direction != Vector2.ZERO:
			return walk
		return idle
	return null
