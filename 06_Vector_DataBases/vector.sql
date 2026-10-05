-- CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS document_embedding (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    content TEXT NOT NULL,
    embedding VECTOR(3)
);

-- CREATE TABLE IF NOT EXISTS summaries (
--     id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     summary TEXT,
--     question TEXT
-- );

-- SELECT extname, extversion
-- FROM pg_extension
-- WHERE extname = 'vector';

-- INSERT INTO document_embedding (content, embedding)
-- VALUES
-- ('Python programming', '[1,2,3]'),
-- ('FastAPI framework', '[2,3,4]'),
-- ('React frontend', '[10,10,10]'),
-- ('Django framework', '[1,3,4]');

SELECT content,embedding <=> '[1,2,3]' AS distance 
FROM document_embedding
ORDER BY embedding <=> '[1,2,3]';