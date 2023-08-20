extends Control

func save(path):
	var file = FileAccess.open(path,FileAccess.WRITE)
	file.store_string($VBoxContainer/TextEdit.text)

func open(path):
	$VBoxContainer/HBoxContainer/LabelPath.text = path
	var file = FileAccess.open(path, FileAccess.READ)
	$VBoxContainer/TextEdit.text = file.get_as_text()

func _ready():
	get_viewport().files_dropped.connect(on_files_dropped)

func on_files_dropped(files):
	print(files)
	open(files[0])


func _on_button_new_pressed():
	$VBoxContainer/TextEdit.clear()


func _on_button_save_pressed():
	$FileDialogSave.popup()


func _on_button_open_pressed():
	$FileDialogOpen.popup()


func _on_file_dialog_save_file_selected(path):
	save(path)


func _on_file_dialog_open_file_selected(path):
	open(path)
