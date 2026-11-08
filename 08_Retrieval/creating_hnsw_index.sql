-- CREATE EXTENSION IF NOT EXISTS vector;

-- CREATE TABLE EMBEDDINGS (
--     ID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
--     CONTENT TEXT,
--     EMBEDDING VECTOR(3)
-- );

-- CREATE INDEX IF NOT EXISTS embeddings_hnsw_idx 
-- ON EMBEDDINGS 
-- USING hnsw (EMBEDDING vector_cosine_ops);

-- SELECT
--     indexname,
--     indexdef
-- FROM pg_indexes
-- WHERE tablename = 'EMBEDDING';

-- INSERT INTO EMBEDDINGS (CONTENT, EMBEDDING) VALUES
-- ('Artificial Intelligence and Machine Learning', '[1.0, 0.9, 0.1]'),
-- ('Baking recipes for chocolate chip cookies', '[0.1, 0.2, 0.9]'),
-- ('Deep learning and neural networks data', '[0.9, 0.8, 0.2]');

-- SET enable_seqscan = off;

-- SELECT 
--     ID,
--     CONTENT ,
--     (1-(EMBEDDING::VECTOR <=> '[0.95, 0.85, 0.15]')) AS SIMILARITY_SCORE
-- FROM EMBEDDINGS
-- ORDER BY embedding <=> '[0.95, 0.85, 0.15]'::vector
-- LIMIT 3;

SELECT
    CONTENT,
    EMBEDDING,
    (1-(EMBEDDING::VECTOR <=> '[0.9,0.8,0.2]')) AS SIMILARITY
FROM EMBEDDINGS
ORDER BY EMBEDDING::VECTOR <=> '[0.9,0.8,0.2]'
LIMIT 3;

-- SELECT * FROM EMBEDDINGS;