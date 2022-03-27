session_name=zero2prod

init () {
	# Usage of the `sqlx::query!` macro requires that DATABASE_URL is set at
	# compile time (unless using offline mode), but tmux doesn't pass the
	# environment variable to new sessions by default. The `sqlx` CLI tool reads
	# the .env file automatically, but Cargo doesn't, so we need to set it
	# manually in the session environment.
	#
	# This only applies if the code uses the `sqlx::query!` macro.
	#
	# See: https://github.com/launchbadge/sqlx#compile-time-verification
	tmux set-environment -t $session_name DATABASE_URL "$DATABASE_URL"
	tmux new-window -d -t $session_name -n 'watch' cargo watch -q \
		-x 'test -q' \
		-x 'clippy -q' \
		-x 'build -q'
	tmux new-window -d -t $session_name -n 'run' cargo watch \
		-c \
		--ignore-nothing \
		-q \
		-w ./target/debug/zero2prod \
		-s ./target/debug/zero2prod
}
