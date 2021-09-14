extends Area2D


export (int) var speed
export (int) var damage
export (float) var steer_force = 0


var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null


func start(position, direction, target = null):
	self.position = position
	rotation = direction.angle()
	velocity = direction * speed
	self.target = target


func seek():
	var desired = (target.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _process(delta: float) -> void:
	if (target):
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
	position += velocity * delta


func explode():
	velocity = Vector2.ZERO
	$Sprite.hide()
	$Explosion.show()
	$Explosion.play('smoke')


func _on_Bullet_body_entered(body: Node) -> void:
	explode()
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_Lifetime_timeout() -> void:
	explode()


func _on_Explosion_animation_finished() -> void:
	queue_free()
