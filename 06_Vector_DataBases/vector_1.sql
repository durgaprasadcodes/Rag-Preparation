CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS document_embedding (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL,
    embedding VECTOR(3)
);

CREATE TABLE IF NOT EXISTS summaries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    summary TEXT,
    question TEXT
);

SELECT extname, extversion
FROM pg_extension
WHERE extname = 'vector';

INSERT INTO document_embedding (content, embedding)
VALUES
    ('ChatGPT Astra','[0.36,0.54,0.89]')
;

SELECT * FROM document_embedding;

SELECT
    '[0.2,0.5,0.8]'::vector
    <=>
    '[0.1,0.7,0.3]'::vector
AS cosine_distance;

SELECT
    1 - (
        '[0.2,0.5,0.8]'::vector
        <=>
        '[0.1,0.7,0.3]'::vector
    ) AS cosine_similarity;

SELECT CONTENT,
    1-(EMBEDDING <=> '[0.4,0.6,0.2]'::VECTOR )
    AS COSINE_SIMILARITY
    FROM document_embedding;