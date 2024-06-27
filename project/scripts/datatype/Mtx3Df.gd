class_name Mtx3Df
extends Object


var _size: int = 0
var _dims: Vector3i
var _storage: Array[float]


func _init(dims: Vector3i, value: float = .0):
	self._dims = dims
	self._size = dims.x * dims.y * dims.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func coords(index: int) -> Vector3i:
	return Vector3i(index / _size ** 2, \
					index / _size ** 2, \
					index / _size ** 2)

func index(x: int, y: int, z: int) -> int:
	pass


