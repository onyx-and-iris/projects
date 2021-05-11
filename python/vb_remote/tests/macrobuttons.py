import voicemeeter
from time import sleep

tests = voicemeeter.remote('banana')

tests._login()

OFF = 0
ON = 1
MODE = 1

# seems to get correct values
# this calls VBVMR_MacroButton_GetStatus
for x in range(5):
    print(tests.button[x].state)

# nothing happening? always false???
# this uses VBVMR_SetParameterFloat
for x in range(3):
    tests.set(f'Command.Button({x}).StateOnly', ON)
    print(tests.button[x].stateonly)

    tests.set(f'Command.Button({x}).StateOnly', OFF)
    print(tests.button[x].stateonly)

# works as expected
# this calls VBVMR_MacroButton_SetStatus, VBVMR_MacroButton_GetStatus respectively
for x in range(3):
    tests.button[x].stateonly = True
    print(tests.button[x].stateonly)

    tests.button[x].stateonly = False
    print(tests.button[x].stateonly)

sleep(1)

# reads correct values if changed in real time
while True:
    print(tests.button[0].state)

tests._logout()
