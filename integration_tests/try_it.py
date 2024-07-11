import requests 
import random

def create_body():
    rando_stuff = random.randbytes(100)
    return rando_stuff * 100


def submit_data(key, data):
    return requests.post(
        f"http://localhost:5858/data/{key}",
        data=data
    )

resp = submit_data("garry", create_body())

resp = submit_data("garry2", "hey girl")
resp = submit_data("garry3", b"hey girl bytes")
print("The status of the test call is:")
print(resp.status_code)
