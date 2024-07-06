extends RigidBody2D

var buoyancy_force = 1000
var in_water = false

func _on_Water_body_entered(body):
	if body == self:
		in_water = true

func _on_Water_body_exited(body):
	if body == self:
		in_water = false

func _integrate_forces(state):
	if in_water:
		var up_force = Vector2(0, -1) * buoyancy_force
		apply_central_force(up_force)
