use serde::Deserialize;

#[derive(Deserialize, Debug)]
pub struct CreateSubject {
    pub name: String,
    pub slug: String,
    pub summary: String,
}
#[derive(Deserialize)]
pub struct UpdateSubject {
    pub id: i32,
    pub name: String,
    pub slug: String,
    pub summary: String,
}
#[derive(Deserialize)]
pub struct CreateTag {
    pub name: String,
}
#[derive(Deserialize)]
pub struct UpdateTag {
    pub id: i32,
    pub name: String,
}

#[derive(Deserialize)]
pub struct CreateTopic {
    pub subject_id: i32,
    pub title: String,
    pub slug: String,
    pub summary: String,
    pub src: String,
    pub author: String,
    pub md: String,
    pub tags: String,
}

#[derive(Deserialize)]
pub struct UpdateTopic {
    pub id: i64,
    pub title: String,
    pub subject_id: i32,
    pub slug: String,
    pub summary: String,
    pub src: String,
    pub author: String,
    pub md: String,
    pub tags: String,
}
#[derive(Deserialize)]
pub struct AdminLogin {
    pub username: String,
    pub password: String,
    pub hcaptcha_response: String,
}
#[derive(Deserialize)]
pub struct GetProctedContent {
    pub id: String,
    pub response: String,
    pub hc:bool,
}

#[derive(Deserialize)]
pub struct CreateAdmin {
    pub username: String,
    pub password: String,
    pub re_password: String,
}
#[derive(Deserialize)]
pub struct UpdateAdmin {
    pub id: i32,
    pub username: String,
    pub password: String,
    pub new_password: String,
    pub re_password: String,
}
#[derive(Deserialize)]
pub struct ChangeAdminPassword {
    pub id: i32,
    pub username: String,
    pub password: String,
    pub new_password: String,
    pub re_password: String,
}
