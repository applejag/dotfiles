
import os

with open(os.path.dirname(__file__)+'/base_config.py') as f:
    exec(f.read())

