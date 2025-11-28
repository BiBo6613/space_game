extends Node2D

var player_in_range = false
var is_open = false

@onready var anim = $AnimationPlayer

# ----------------------
#  Обнаружение игрока
# ----------------------

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") or body.name == "player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player") or body.name == "player":
		player_in_range = false
		if is_open:
			close_door()


# ----------------------
#     Логика ввода
# ----------------------

func _process(delta):
	if player_in_range and not is_open:
		if Input.is_action_just_pressed("interact"):
			open_door()


# ----------------------
#      Анимация
# ----------------------

func open_door():
	is_open = true
	anim.play("open")

func close_door():
	is_open = false
	anim.play("close")
