from fastapi import APIRouter,HTTPException
from pydantic import BaseModel
from services.image_Generator import generateImage,generateNoofPrompts
router = APIRouter()
import asyncio
import concurrent.futures

@router.get("/hello")
def say_hello():
    return {"message": "Hello from another route!"}

def generate_story_prompts():
    story_prompts = [
    ]
    return story_prompts

async def generate_multiple_images(prompts):
    loop = asyncio.get_event_loop()
    with concurrent.futures.ThreadPoolExecutor() as pool:
        results = await asyncio.gather(*[
            loop.run_in_executor(pool, generateImage, prompt) for prompt in prompts
        ])
    return results
class TextInput(BaseModel):
    text: str
    images:int
    
    
@router.post("/generateImage")
async def generate_image(input: TextInput):
    new_prompts = generateNoofPrompts(input.text, input.images)
    story_prompts = generate_story_prompts()
    story_prompts.extend(new_prompts)
    responses = await generate_multiple_images(story_prompts)
    return {"total_images": len(responses), "images": responses}