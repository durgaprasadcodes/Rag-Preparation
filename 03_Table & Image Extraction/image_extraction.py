import pymupdf
import base64
import os
from dotenv import load_dotenv
from langchain.chat_models import init_chat_model
from langchain_core.messages import HumanMessage

load_dotenv()

# ── Model ────────────────────────────────────────────────────────────────────
model = init_chat_model(
    "qwen/qwen3.8-27b",
    model_provider="groq",
    timeout=30,
    max_tokens=1000,
    max_retries=3
)

# ── Helper ───────────────────────────────────────────────────────────────────
def encoding_image(path):
    with open(path, "rb") as f:
        return base64.b64encode(f.read()).decode("utf-8")

# ── Extract images from PDF → encode → send to model ────────────────────────
pdf_path = r"C:\Users\rolex\OneDrive\Desktop\RAG\data\image_pdf.pdf"
document = pymupdf.open(pdf_path)

for page_num, page in enumerate(document):
    image_list = page.get_images(full=True)

    if not image_list:
        print(f"Page {page_num + 1}: No images found\n")
        continue

    for img_index, img_info in enumerate(image_list):
        xref = img_info[0]  # xref ID of the image

        # Extract raw image bytes from PDF
        base_image = document.extract_image(xref)
        image_bytes = base_image["image"]
        image_ext   = base_image["ext"]   # e.g. 'png', 'jpeg'

        # Save temporarily to disk so encoding_image() can read it
        temp_path = f"temp_page{page_num+1}_img{img_index+1}.{image_ext}"
        with open(temp_path, "wb") as f:
            f.write(image_bytes)

        # Base64 encode via encoding_image
        encoded = encoding_image(temp_path)

        # Build multimodal message and send to vision model
        message = HumanMessage(
            content=[
                {
                    "type": "text",
                    "text": "Extract all important information from this image."
                },
                {
                    "type": "image_url",
                    "image_url": {
                        "url": f"data:image/{image_ext};base64,{encoded}"
                    }
                }
            ]
        )

        print(f"--- Page {page_num + 1}, Image {img_index + 1} ---")
        response = model.invoke([message])
        print(response.content.encode("utf-8", errors="replace").decode("utf-8"))
        print()

        # Clean up temp file
        os.remove(temp_path)
