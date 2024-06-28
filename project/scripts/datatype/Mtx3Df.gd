class_name Mtx3Df
extends Object


var _dim: Vector3i
var _size: int = 0
var _storage: Array[float]


func _init(dim: Vector3i, value: float = .0):
	self._dim = dim
	self._size = dim.x * dim.y * dim.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func coords(index: int) -> Vector3i:
	return Vector3i()

func index(x: int, y: int, z: int) -> int:
	return x + self._dim.x * (y + self._dim.y * z)


