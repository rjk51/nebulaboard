from openai import OpenAI
from config import settings

client = OpenAI(
    base_url="https://api.studio.nebius.com/v1/",
    api_key=settings.VIBEPICK,
)

def generateImage(prompt:str):
    response = client.images.generate(
        model="stability-ai/sdxl",
        response_format="b64_json",
        extra_body={
            "response_extension": "png",
            "width": 350,  # Smaller size
            "height": 350,
            "num_inference_steps": 10,  # Fewer steps
            "negative_prompt": "",
            "seed": 42 
        },
        prompt=prompt
    )

    print(response.to_json())
    return response.to_json()

def generateNoofPrompts(prompt:str, no_of_prompts:int):
    response = client.chat.completions.create(
    model="google/gemma-2-2b-it",
    max_tokens=512,
    temperature=0.5,
    top_p=0.9,
    extra_body={
        "top_k": 50
    },
    messages=[
            {
                "role": "system",
                "content": "You are a creative storyteller generating prompts for a series of AI-generated images."
            },
            {
                "role": "user",
                "content": f"Generate {no_of_prompts} short, engaging story prompts related to '{prompt}'. "
                            f"Each prompt should be concise and describe a single scene for an AI-generated image."
            }
        ]
    )

    print(response.to_json())
    return response.to_json()