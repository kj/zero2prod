session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n test cargo watch -c -q -x 'test -q'
	tmux new-window -d -t $session_name -n run cargo watch -c -q -x 'run -q'
	tmux new-window -d -t $session_name -n clippy cargo watch -c -q -x 'clippy -q'
}
