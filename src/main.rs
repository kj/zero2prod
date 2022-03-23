use std::net::TcpListener;
use zero2prod::config::get_config;
use zero2prod::startup::run;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let config = get_config()
        .expect("Failed to read configuration");
    let address = format!("[::1]:{}", config.application_port);
    let listener = TcpListener::bind(address)
        .expect("Failed to bind address");
    println!("Listening on [::1]:8080");
    run(listener)?.await
}
