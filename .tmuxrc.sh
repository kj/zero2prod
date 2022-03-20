session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n test cargo watch -c -x test
	tmux new-window -d -t $session_name -n run cargo watch -c -x run
	tmux new-window -d -t $session_name -n clippy cargo watch -c -x clippy
}
