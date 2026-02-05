extends Node
class_name StateMachine

# This component will hold an instance of a parent object
# Responsible for managing the state of the parent by delegating the active
# state to child state nodes
# Handle state transitions

@export 
var starting_state: State
var current_state: State

# Initialize the state machine by giving each child a reference
# to the parent object and initialize the default state.
func init(_parent: Node) -> void:
	pass

# Change to a new state and call any exit logic on the current state
func change_state(_new_state: State) -> void:
	pass

# Pass through functions for the parent to call
# Each flow might return an optional new state
# If a new state is returned, the state machine will handle the transition
func process_physics(_delta: float) -> void:
	pass

func process_input(_event: InputEvent) -> void:
	pass

func process_frame(_delta: float) -> void:
	pass
