extends Camera2D

@export var smooth_speed := 5.0
@export var deadzone := Rect2(Vector2(-50, -30), Vector2(100, 60)) # x, y, width, height

var target_position := Vector2.ZERO

func _process(delta):
	var player = get_node("../Player")
	var screen_pos = to_local(player.global_position)

	# Если игрок вышел из deadzone — камера двигается
	if not deadzone.has_point(screen_pos):
		target_position = player.global_position

	# Плавное движение
	global_position = global_position.lerp(target_position, delta * smooth_speed)
