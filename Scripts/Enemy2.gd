extends KinematicBody2D

export var limit_y = 350
export var score = 15
export var speed = 2.0
export var move_probability = 0.09
export var fire_probability = 0.45

onready var EnemyBullet = load("res://Scenes/EnemyBullet.tscn")

var ready = false

var new_position = Vector2(0,0)

func get_new_position():
	var VP = get_viewport_rect().size
	new_position.x = randi() % int(VP.x)
	new_position.y = min(randi() % int(VP.y), int(VP.y) - limit_y)
	$Tween.interpolate_property(self, "position", position, new_position, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	ready = true

func die():
	queue_free()


func _ready():
	randomize()
	get_new_position()


func _physics_process(delta):
	if ready:
		$Tween.start()
		ready = false
	


func _on_Timer_timeout():
	if randf() < move_probability:
		get_new_position()
	if randf() < fire_probability:
		var v = EnemyBullet.instance()
		v.position = position
		v.position.y += 25
		get_node("/root/Game/Enemy Bullets").add_child(v)
