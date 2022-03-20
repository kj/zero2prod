use std::net::TcpListener;
use zero2prod::run;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("[::1]:8080")
        .expect("Failed to bind to random port");
    println!("Listening on [::1]:8080");
    run(listener)?.await
}
