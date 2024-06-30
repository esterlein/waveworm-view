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
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format("index": index))
		return Vector3i()
	var x: int = index % self._dim.x
	var y: int = ((index - x) / self._dim.x) % self._dim.y
	var z: int = (index - x - self._dim.x * y)/(self._dim.x * self._dim.y)
	return Vector3i(x, y, z)

func index(x: int, y: int, z: int) -> int:
	return x + self._dim.x * (y + self._dim.y * z)


