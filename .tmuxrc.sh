session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n check bacon check
	tmux new-window -d -t $session_name -n clippy bacon clippy
	tmux new-window -d -t $session_name -n test bacon test
	tmux new-window -d -t $session_name -n run cargo watch -x run
}
