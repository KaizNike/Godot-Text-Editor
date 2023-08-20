extends Control

func save(path):
	var file = FileAccess.open(path,FileAccess.WRITE)	
	file.store_string($VBoxContainer/TextEdit.text)
	file.close()

func download(path, file_name):
	print("Downloading: " + file_name)
	download_text($VBoxContainer/TextEdit.text, file_name)

func open(path):
	$VBoxContainer/HBoxContainer/LabelPath.text = path
	var file = FileAccess.open(path, FileAccess.READ)
	$VBoxContainer/TextEdit.text = file.get_as_text()
	file.close()

func download_text(text: String, filename: String = "download.txt"):
#	text = text.replace("\n", "%0A")
	var js_code : String = """
	var element = document.createElement('a');
	element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(`%s`));
	element.setAttribute('download', '%s');
	element.style.display = 'none';
	document.body.appendChild(element);
	element.click();
	document.body.removeChild(element);
	""" % [text, filename]
	JavaScriptBridge.eval(js_code)

func _ready():
	if OS.get_name() != "Web":
		$VBoxContainer/HBoxContainer/ButtonDownload.visible = false
	get_viewport().files_dropped.connect(on_files_dropped)

func on_files_dropped(files):
	print(files)
	open(files[0])


func _on_button_new_pressed():
	$VBoxContainer/HBoxContainer/LabelPath.text = "path"
	$VBoxContainer/TextEdit.clear()


func _on_button_save_pressed():
	$FileDialogSave.popup()

func _on_button_download_pressed():
	$FileDialogDownload.popup()

func _on_button_open_pressed():
	$FileDialogOpen.popup()


func _on_file_dialog_save_file_selected(path):
	save(path)


func _on_file_dialog_open_file_selected(path):
	open(path)

func _on_file_dialog_download_file_selected(path):
	download(path, $FileDialogSave.current_file)
