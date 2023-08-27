extends Node2D

var pointArray:PackedVector2Array
var mousePoint:= Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(pointArray)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sampleSize: = 10
	var samples:float = 1.0/sampleSize
	
	for i in sampleSize + 1:
		var point = i*samples
		var curvePoint = _quadratic_bezier(Vector2(0,0), Vector2(0,-1000), mousePoint, point)
		pointArray.append(curvePoint)
		
	mousePoint = get_local_mouse_position()
	queue_redraw()

func _draw():
	draw_polyline(pointArray, Color.BLACK)
	pointArray = []

## Calculates a point in bezier curve. 0<t<1
func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
