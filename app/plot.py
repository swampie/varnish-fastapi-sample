from fastapi import FastAPI
import time
import random
app = FastAPI()


@app.on_event("startup")
async def startup():
    print('Starting up')


@app.get('/plot')
def plot():
    rand_sleep = random.randint(1, 10)
    time.sleep(rand_sleep)

    return {'delay': str(rand_sleep)}
