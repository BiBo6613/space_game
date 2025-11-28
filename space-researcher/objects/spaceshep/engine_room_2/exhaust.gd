extends Node2D


@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	anim_sprite.play("default")  # запускает анимацию "idle"
