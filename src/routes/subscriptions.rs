use actix_web::{web::Form, HttpResponse, Responder};

#[derive(serde::Deserialize)]
pub struct FormData {
    email: String,
    name: String,
}

pub async fn create_subscription(_form: Form<FormData>) -> impl Responder {
    HttpResponse::Ok()
}
