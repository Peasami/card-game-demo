# This node manages the targeting line for cards. 
# _process() starts disabled.

extends Node2D

@export var bezierCurve2ndPoint: Vector2

var pointArray:PackedVector2Array
var mousePoint:= Vector2(0,0)
var lineColor := Color.BLACK

func _ready():
	## We disable this node, and enable only when needed
	set_process(false)

func _process(_delta):
	var sampleSize: = 10
	var samples:float = 1.0/sampleSize
	
	for i in sampleSize + 1:
		var point = i*samples
		var curvePoint = _quadratic_bezier(Vector2(0,0), bezierCurve2ndPoint, mousePoint, point)
		pointArray.append(curvePoint)
		
	mousePoint = get_local_mouse_position()
	queue_redraw()

func _draw():
	if pointArray.size() >= 2:
		draw_polyline(pointArray, lineColor)
		pointArray = []

func clear_draw():
	pointArray.clear()
	queue_redraw()

## Calculates a point in bezier curve. 0<t<1
func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r

func targeting_line_valid():
	lineColor = Color.RED

func targeting_line_invalid():
	lineColor = Color.BLACK
