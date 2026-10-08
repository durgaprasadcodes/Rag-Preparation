from openai import OpenAI
from dotenv import load_dotenv
import os
load_dotenv()

OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
OPENROUTER_RERANKING_API_KEY = os.getenv("OPENROUTER_RERANKING_API_KEY")

client = OpenAI(
  base_url="https://openrouter.ai/api/v1",
  api_key=OPENROUTER_API_KEY,
)

embedding = client.embeddings.create(
  model="nvidia/nemotron-3-embed-1b:free",
  input="hello broo",
  encoding_format="float"
)
print(embedding.data[0].embedding)

