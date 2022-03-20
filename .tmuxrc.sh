session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n check cargo watch -x check -x test -x run
}
