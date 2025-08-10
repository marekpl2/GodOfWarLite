extends CharacterBody3D

@export var max_health := 80
@export var move_speed := 2.0
@export var chase_range := 10.0
@export var attack_range := 1.3
var health := max_health

onready var player := null

func _ready():
    player = get_tree().get_root().get_node_or_null("/root/Main/Player") if Engine.is_editor_hint() == false else null
    # fallback: try find by group
    if not player and get_tree():
        var nodes = get_tree().get_nodes_in_group("player_group")
        if nodes.size() > 0:
            player = nodes[0]

func _physics_process(delta):
    if player == null:
        return
    var dist = global_transform.origin.distance_to(player.global_transform.origin)
    if dist <= chase_range and dist > attack_range:
        var dir = (player.global_transform.origin - global_transform.origin).normalized()
        velocity.x = dir.x * move_speed
        velocity.z = dir.z * move_speed
        move_and_slide()
        look_at(player.global_transform.origin, Vector3.UP)
    elif dist <= attack_range:
        # attack player
        if player.has_method("take_damage"):
            player.take_damage(10)

func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free()
