extends Control

var points = []
var xEllipseCenter
var yEllipseCenter

func _draw():
	for i in range(points.size() - 1):
		draw_line(points[i], points[i + 1], Color(1, 1, 1))
	
	draw_rect(Rect2(xEllipseCenter-10,yEllipseCenter-10,10,10),Color.CRIMSON)
