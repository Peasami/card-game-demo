extends Node

var xAxis: float = 0

#var ellipse = (xAxis^2/3^2)+(yAxis^2/2^2) - 1
var xAxelEllipse = 450
var yAxelEllipse = xAxelEllipse/4
var xClampValue = xAxelEllipse-50
var yAxis = calculate_ellipse_y()
var selectedCard


func calculate_ellipse_y():
	return (-yAxelEllipse*(pow((pow(xAxelEllipse,2))-(pow(xAxis,2)), 0.5)))/xAxelEllipse

func draw_card():
	var handSize = $"..".get_hand_size()
	xAxis = (handSize-1) * 100
	animate_movement()

func move_card_hand(amount: float):
	xAxis = xAxis + amount
	animate_movement()

func animate_movement():
	var tween = create_tween().set_parallel(true)
	tween.tween_property($"..", 'position', Vector2(xAxis + 512, calculate_ellipse_y() + 720), 0.2)
	tween.tween_property($"..", 'rotation', xAxis/1500, 0.2)
