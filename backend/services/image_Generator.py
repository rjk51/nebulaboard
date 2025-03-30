from openai import OpenAI
from config import settings
import re

client = OpenAI(
    base_url="https://api.studio.nebius.com/v1/",
    api_key=settings.VIBEPICK,
)

def generateImage(prompt:str):
    print(f"Generating image for prompt: {prompt}")
    response = client.images.generate(
        model="stability-ai/sdxl",
        response_format="b64_json",
        extra_body={
            "response_extension": "png",
            "width": 500,  
            "height": 500,
            "num_inference_steps": 30,  
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
                "content": "You are a creative storyteller tasked with generating prompts for AI-generated images. Your response must strictly be a numbered list (e.g., '1. Prompt text') with no additional text before or after the list."
            },
            {
                "role": "user",
                "content": f"Generate exactly {no_of_prompts} short, engaging story prompts related to '{prompt}'. Each prompt must be concise, describe a single scene for an AI-generated image, and be formatted as a numbered list item (e.g., '1. Prompt text'). Do not include any introductory or concluding text—just the numbered prompts."
            }
        ]
    )

    # print(response.to_json())
    prompts_text = response.choices[0].message.content

    prompts = []
    for line in prompts_text.split("\n"):
        if line.strip() and re.match(r'^\d+\.\s', line):
            prompt = re.sub(r'^\d+\.\s', '', line).strip()
            print(f"Prompt: {prompt}")
            prompts.append(prompt)
    
    return prompts