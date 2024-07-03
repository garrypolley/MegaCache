import requests 
import random

def create_body():
    rando_stuff = random.randbytes(10_000)
    return rando_stuff  * 1_000


def submit_data(key, data):
    return requests.post(
        f"http://localhost:5857/data/{key}",
        data=data
    )

resp = submit_data("garry", create_body())
print("The status of the test call is:")
print(resp.status_code)
