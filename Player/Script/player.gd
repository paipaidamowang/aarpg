class_name player extends CharacterBody2D


var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var effect_animation_player: AnimationPlayer = $Sprite2D/AttackEffectSprite/AnimationPlayer

signal DirectionChanged( new_direction : Vector2 )

func _ready():
	state_machine.Initialize(self )

func _process(delta: float):
	direction = Input.get_vector("left", "right", "up", "down")
	direction = direction.normalized()
	
func _physics_process(delta: float):
	move_and_slide()


func SetDirection() -> bool:
	var new_dir: Vector2 = cardinal_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	else:
		# 斜向移动：y 轴优先
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir
	DirectionChanged.emit( new_dir )
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	

func UpdateAnimation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())

func PlayAttackEffect() -> void:
	effect_animation_player.play("attack_" + AnimDirection())


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
