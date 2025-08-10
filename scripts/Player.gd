extends CharacterBody3D

@export var move_speed := 4.5
@export var gravity := ProjectSettings.get_setting("physics/3d/default_gravity")
@export var jump_velocity := 5.5
@export var attack_damage := 25
@export var attack_cooldown := 0.8
var attack_timer := 0.0

onready var cam_pivot = $CameraPivot
onready var attack_area = $AttackArea

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    attack_area.connect("area_entered", Callable(self, "_on_attack_area_entered"))

func _process(delta):
    _update_attack_timer(delta)

func _physics_process(delta):
    var input_dir = Vector3.ZERO
    input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
    input_dir.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
    if input_dir.length() > 0.1:
        input_dir = input_dir.normalized()
        # transform input by camera
        var cam = get_viewport().get_camera_3d()
        if cam:
            var forward = -cam.global_transform.basis.z
            forward.y = 0
            forward = forward.normalized()
            var right = cam.global_transform.basis.x
            right.y = 0
            right = right.normalized()
            var dir = (forward * input_dir.z + right * input_dir.x).normalized()
            velocity.x = dir.x * move_speed
            velocity.z = dir.z * move_speed
            look_at(global_transform.origin + dir, Vector3.UP)
    else:
        velocity.x = move_toward(velocity.x, 0, move_speed)
        velocity.z = move_toward(velocity.z, 0, move_speed)

    if not is_on_floor():
        velocity.y -= gravity * delta
    else:
        if Input.is_action_just_pressed("ui_accept"):
            velocity.y = jump_velocity

    move_and_slide()

    _camera_control(delta)

func _camera_control(delta):
    var mouse_motion = Input.get_last_mouse_velocity() * -0.02
    cam_pivot.rotate_y(deg2rad(mouse_motion.x))

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            attack()

func attack():
    if attack_timer > 0:
        return
    attack_timer = attack_cooldown
    $AnimationPlayer.play("attack") if $AnimationPlayer else null
    # enable area for a short moment
    attack_area.monitoring = true
    yield(get_tree().create_timer(0.15), "timeout")
    attack_area.monitoring = false

func _update_attack_timer(delta):
    if attack_timer > 0:
        attack_timer -= delta

func _on_attack_area_entered(area):
    # if area belongs to enemy, apply damage
    var enemy = area.get_parent()
    if enemy and enemy.has_method("take_damage"):
        enemy.take_damage(attack_damage)
