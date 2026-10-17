extends Node2D

func use_face_happy() -> void:
	turn_off_faces()
	$Face/FaceHappy.visible = true

func use_face_normal() -> void:
	turn_off_faces()
	$Face/FaceNormal.visible = true
	
func use_face_sad() -> void:
	turn_off_faces()
	$Face/FaceSad.visible = true
	
func turn_off_faces() -> void:
	for child in $Face.get_children():
		child.visible = false
