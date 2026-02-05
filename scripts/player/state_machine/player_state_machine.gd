extends StateMachine


func init(parent: Node) -> void:
	for child in get_children():
		child.parent = parent
	
	# Initialize the default state
	change_state(starting_state)

# Change to a new state and call any exit logic on the current state
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()

# Pass through functions for the parent to call
# Each flow might return an optional new state
# If a new state is returned, the state machine will handle the transition
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
