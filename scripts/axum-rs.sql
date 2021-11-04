CREATE TABLE subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    summary VARCHAR(255) NOT NULL,
    is_del BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(slug)
);

CREATE INDEX idx_subject_slug ON subject (slug);

CREATE TABLE topic (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    subject_id INTEGER NOT NULL REFERENCES subject(id),
    slug VARCHAR(100) NOT NULL,
    summary VARCHAR(255) NOT NULL,
    author VARCHAR(50) NOT NULL,
    hit INTEGER NOT NULL DEFAULT 0,
    dateline INTEGER NOT NULL DEFAULT 0,
    is_del BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(subject_id, slug)
);

CREATE INDEX idx_topic_slug ON topic (slug);

CREATE TABLE topic_content (
    topic_id BIGINT NOT NULL PRIMARY KEY REFERENCES topic(id),
    md VARCHAR NOT NULL,
    html VARCHAR NOT NULL
);

CREATE TABLE tag (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    is_del BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE(name)
);

CREATE INDEX idx_tag_name ON tag (name);

CREATE TABLE topic_tag (
    topic_id BIGINT NOT NULL REFERENCES topic(id),
    tag_id INT NOT NULL REFERENCES tag(id),
    is_del BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY(topic_id,tag_id)
);

-- 视图
-- 用于列表显示的文章和主题
CREATE VIEW v_topic_subject_list AS
    SELECT t.id, t.title, t.slug, s.name AS subject_name, s.slug AS subject_slug, t.subject_id, t.is_del, s.is_del AS subject_is_del
    FROM topic AS t
    INNER JOIN subject AS s
    ON t.subject_id=s.id;

-- 用于列表显示的文章和主题及标签
CREATE VIEW v_topic_subject_list_with_tags AS
    SELECT tsl.id,title,slug,subject_name,subject_slug,subject_id,tsl.is_del,subject_is_del
        ,tt.tag_ids,tt.tag_names
    FROM v_topic_subject_list AS tsl
    LEFT JOIN (
        SELECT
            tt.topic_id,
            array_agg(t.name) AS tag_names,
            array_agg(tt.tag_id) AS tag_ids
        FROM topic_tag AS tt
        INNER JOIN tag AS t ON t.id=tt.tag_id
        WHERE tt.is_del=false AND t.is_del=false
        GROUP BY tt.topic_id
    ) AS tt on tt.topic_id=tsl.id;
