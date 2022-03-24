session_name=zero2prod

init () {
	tmux new-window -d -t $session_name -n 'watch' cargo watch -q -s '
		clear && cargo test -q &&
		clear && cargo clippy -q &&
		clear && cargo build -q'
	tmux new-window -d -t $session_name -n 'run' cargo watch \
		-c \
		--ignore-nothing \
		-q \
		-w ./target/debug/zero2prod \
		-s ./target/debug/zero2prod
}
