use std::net::TcpListener;
use sqlx::PgPool;
use zero2prod::config::get_config;
use zero2prod::startup::run;

#[tokio::main]
async fn main() -> std::io::Result<()> {
    let config = get_config()
        .expect("Failed to read configuration");
    let pool = PgPool::connect(&config.database.connection_string())
        .await
        .expect("Failed to connect to PostgreSQL");
    let address = format!("[::1]:{}", config.app.port);
    let listener = TcpListener::bind(address)
        .expect("Failed to bind address");
    println!("Listening on [::1]:8080");
    run(listener, pool)?.await
}
