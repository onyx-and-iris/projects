# testing python wrapper for voicemeeter
# https://github.com/chvolkmann/voicemeeter-remote-python
# TODO> rewrite macro buttons using python wrapper
import voicemeeter

# Can be 'basic', 'banana' or 'potato'
kind = 'banana'

# Ensure that Voicemeeter is launched
voicemeeter.launch(kind)

with voicemeeter.remote(kind) as oai:
    print(oai.type)
    
    oai.dirty
    
    status=oai.get("Strip[3].A1")
    status2=oai.get("Strip[3].A2")
    status3=oai.get("Strip[3].A3")
    print(int(status))
    print(int(status2))
    print(int(status3))
    print(f'Output A1 of Strip 3 {oai.inputs[3].label}: {oai.inputs[3].A1}')
    print(f'Output A2 of Strip 3 {oai.inputs[3].label}: {oai.inputs[3].A2}')
    print(f'Output A3 of Strip 3 {oai.inputs[3].label}: {oai.inputs[3].A3}')
