import requests

headers = {
    'Authorization': 'mainToken',
    'Content-Type': 'application/json',
}

data = '{\n    "id": 123,\n    "jsonrpc": "2.0",\n    "method": "person.info",\n    "params":{\n        "person_id":"3333",\n        "token":"customToken"\n    }\n  }'

response = requests.post('http://rscu.gx.uz/app', headers=headers, data=data)
response.json()