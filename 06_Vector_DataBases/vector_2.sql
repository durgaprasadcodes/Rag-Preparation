
SELECT CONTENT,
    1-(
        EMBEDDING <=> '[0.4,0.6,0.2]'
    )
    AS COSINE_SIMILARITY
FROM document_embedding;


SELECT CONTENT,
    EMBEDDING <-> '[0.4,0.6,0.2]'
    AS l2_distance
FROM document_embedding;

