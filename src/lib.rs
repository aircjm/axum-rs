pub mod arg;
pub mod cache;
pub mod config;
pub mod db;
pub mod error;
pub mod form;
pub mod handler;
pub mod hcaptcha;
pub mod html;
pub mod md;
pub mod middleware;
pub mod model;
pub mod password;
pub mod rdb;
pub mod session;
pub mod time;
pub mod recaptcha;

/// 结果
type Result<T> = std::result::Result<T, self::error::AppError>;
