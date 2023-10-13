import json

src = """
{P"THIS": "IS", "A": "JSON", "FILE": "!"}
"""
# decode json
data = json.loads(src)
