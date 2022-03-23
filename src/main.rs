use std::net::TcpListener;
use zero2prod::startup::run;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("[::1]:8080")
        .expect("Failed to bind address");
    println!("Listening on [::1]:8080");
    run(listener)?.await
}
