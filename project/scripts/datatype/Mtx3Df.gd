class_name Mtx3Df
extends Object


var _size: int = 0
var _storage: Array[float]


func _init(size: int, value: float = 0):
	self._size = size
	self._storage.resize(size ** 3)
	self._storage.fill(value)

func coords(index: int) -> Vector3i:
	pass

func index(x: int, y: int, z: int) -> int:
	pass
