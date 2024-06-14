@tool
extends Node3D


var random_seed: int = 0


func _ready():
	generate()


func _process(delta):
	pass
	
	
func generate() -> void:
	seed(random_seed)
	
	var caster: Caster = Caster.new()
