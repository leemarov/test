extends Button

var name1 = ""
var name2 = ""
var spin1 = false
var spin2 = false
var counter = 0
const COUNTER1 = 100
const COUNTER2 = 200
var list = ["Naruto","Sausuke","Shino","Onoma","Komori","Seishu"]
var listE = list


func _ready():
	disable_all_list()
	for names in list:
		create_list_button(names)

func _pressed():
	if names_left() > 1:
		randomize()
		counter = 0	
		while true:
			name1 = get_rand_name()
			name2 = get_rand_name()
			while name1 == name2:
				name2 = get_rand_name()
			if check_name(name1) && check_name(name2):
				break
		spin1 = true
		spin2 = true
		disable_name(name1)
		disable_name(name2)
		$"../l1".text = name1
		$"../l2".text = name2

func _process(dt):
	counter+=1
	if counter>COUNTER1:
		spin1 = false
	if counter>COUNTER2:
		spin2 = false
	if spin1:
		$"../l1".text = get_rand_name()
	else:
		$"../l1".text = name1
	if spin2:
		$"../l2".text = get_rand_name()
	else:
		$"../l2".text = name2
		
func get_rand_name():
	return list[randi()%list.size()]

func disable_name(name):
	for x in $list.get_children():
		if x.text == name:
			x.pressed = true
			
func check_name(name):
	for x in $list.get_children():
		if x.text == name:
			return !x.pressed
	return false
	
func names_left():
	var c = 0
	for x in $list.get_children():
		if x.pressed == false:
			c = c+1
	return c
	
func enable_all_list():
	for x in $list.get_children():
		x.pressed = false

func disable_all_list():
	for x in $list.get_children():
		x.pressed = true
		
func create_list_button(n):
	var node = Button.new()
	node.set_name(n)
	node.toggle_mode = true
	node.text = n
	$list.add_child(node)

func _on_reset_pressed():
	enable_all_list()

func _on_hide_toggled(button_pressed):
	if button_pressed:
		$list.hide()
	else:
		$list.show()
