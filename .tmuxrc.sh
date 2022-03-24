session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n 'test' cargo watch -c -q -x 'test -q'
	tmux new-window -d -t $session_name -n 'clippy' cargo watch -c -q -x 'clippy -q'
	tmux new-window -d -t $session_name -n 'build' cargo watch -c -q -x 'build -q'
	tmux new-window -d -t $session_name -n 'run' cargo watch -c --ignore-nothing -q -w target/debug/zero2prod -s ./target/debug/zero2prod
}
