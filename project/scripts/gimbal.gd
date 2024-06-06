class_name Gimbal
extends Node3D


@onready var camera: Camera3D = $InnerGimbal/Camera
@onready var innergimbal: Node3D = $InnerGimbal

@export var max_zoom_in: float = 3.0
@export var max_zoom_out: float = 100
@export var zoom_speed: float = 1

var zoom: float = 1.5

@export var speed: float = 0.3
@export var drag_speed: float = 0.005
@export var acceleration: float = 0.08
@export var mouse_sensitivity: float = 0.005

var move = Vector3()


func _ready():
	pass

func _input(event):
	if Input.is_action_pressed("cam_rotate"):
		if event is InputEventMouseMotion:
			if event.relative.x != 0:
				rotate_object_local(Vector3.UP, -event.relative.x * self.mouse_sensitivity)
			if event.relative.y != 0:
				var y_rotation = clamp(-event.relative.y, -30, 30)
				self.innergimbal.rotate_object_local(Vector3.RIGHT, y_rotation * self.mouse_sensitivity)
	if Input.is_action_pressed("cam_move"):
		if event is InputEventMouseMotion:
			self.move.x -= event.relative.x * self.drag_speed
			self.move.z -= event.relative.y * self.drag_speed
	
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= self.zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += self.zoom_speed
	zoom = clamp(zoom, self.max_zoom_in, self.max_zoom_out)


func _process(delta):
	scale = lerp(scale, Vector3.ONE * self.zoom, self.zoom_speed)
	self.innergimbal.rotation.x = clamp(self.innergimbal.rotation.x, -1.1, 0.3)
	move_cam(delta)

func move_cam(delta):
	if Input.is_action_pressed("cam_forward"):
		self.move.z = lerp(self.move.z, -self.speed, self.acceleration)
	elif Input.is_action_pressed("cam_backward"):
		self.move.z = lerp(self.move.z, self.speed, self.acceleration)
	else:
		self.move.z = lerp(self.move.z, 0.0, self.acceleration)
	if Input.is_action_pressed("cam_left"):
		self.move.x = lerp(self.move.x, -self.speed, self.acceleration)
	elif Input.is_action_pressed("cam_right"):
		self.move.x = lerp(self.move.x, self.speed, self.acceleration)
	else:
		self.move.x = lerp(self.move.x, 0.0, self.acceleration)
	
	self.position += self.move.rotated(Vector3.UP, self.rotation.y) * self.zoom
	self.position.x = clamp(self.position.x,-20,20)
	self.position.z = clamp(self.position.z,-20,20)
	
