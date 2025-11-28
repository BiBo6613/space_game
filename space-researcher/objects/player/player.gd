extends CharacterBody2D

# Движение
@export var speed = 100.0

# Состояние
var current_direction = "down"  # Последнее направление
var has_keycard = false # По умолчанию карты нет

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Получаем ввод WASD
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("left", "right")  # A/D или стрелки влево-вправо
	input_vector.y = Input.get_axis("up", "down")     # W/S или стрелки вверх-вниз
	
	# Нормализуем вектор (чтобы диагональное движение не было быстрее)
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		update_animation(input_vector)
	else:
		velocity = Vector2.ZERO
		play_idle_animation()
	
	move_and_slide()

func update_animation(direction: Vector2):
	# Определяем основное направление (вверх, вниз, влево, вправо)
	var abs_x = abs(direction.x)
	var abs_y = abs(direction.y)
	
	if abs_y > abs_x:  # Вертикальное движение доминирует
		if direction.y < 0:
			current_direction = "up"
		else:
			current_direction = "down"
	else:  # Горизонтальное движение доминирует
		if direction.x < 0:
			current_direction = "left"
		else:
			current_direction = "right"
	
	play_animation("walk_" + current_direction)

func play_idle_animation():
	play_animation("idle_" + current_direction)

func play_animation(anim_name: String):
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)

func take_damage(damage: int):
	print("Персонаж получил урон: ", damage)

func die():
	print("Персонаж умер")
