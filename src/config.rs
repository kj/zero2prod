use config::{Config, ConfigError, File};

#[derive(serde::Deserialize)]
pub struct Settings {
    pub app: AppSettings,
    pub database: DatabaseSettings,
}

#[derive(serde::Deserialize)]
pub struct AppSettings {
    pub port: u16,
}

#[derive(serde::Deserialize)]
pub struct DatabaseSettings {
    pub username: String,
    pub password: String,
    pub host: String,
    pub port: u16,
    pub database_name: String,
}

impl DatabaseSettings {
    pub fn connection_string(&self) -> String {
        format!(
            "postgres://{}:{}@{}:{}/{}",
            self.username,
            self.password,
            self.host,
            self.port,
            self.database_name,
        )
    }

    pub fn connection_string_without_database(&self) -> String {
        format!(
            "postgres://{}:{}@{}:{}",
            self.username,
            self.password,
            self.host,
            self.port,
        )
    }
}

pub fn get_config() -> Result<Settings, ConfigError> {
    let mut settings = Config::default();
    settings.merge(File::with_name("config"))?;
    settings.try_into()
}
