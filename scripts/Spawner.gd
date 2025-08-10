extends Node3D

@export var enemy_scene: PackedScene
@export var spawn_count := 4
@export var radius := 8.0

func _ready():
    for i in range(spawn_count):
        var p = enemy_scene.instantiate()
        var angle = randf() * PI * 2.0
        var pos = Vector3(cos(angle)*radius, 0, sin(angle)*radius) + global_transform.origin
        p.global_transform.origin = pos
        get_parent().add_child(p)
