import os
import datetime
import random
import pyautogui as m
import time

def findPosition():
    while True:
        x, y = m.position()
        print(f"mouse is x:{x} y:{y}")

def discordMouse():
    m.moveTo(-185, 159)
    time.sleep(.5)
    m.leftClick()

    time.sleep(2)
    m.moveTo(-491, 576)
    m.leftClick()

    time.sleep(6)

# gives time to move hand out of way
# time.sleep(2)
# while True:
#     discordMouse()


def makeLoot():
    os.system('curl -X POST -H <insert own custom header> https://discord.com/api/v9/users/@me/lootboxes/open ')

startTime = datetime.datetime.now()
limit = 0

def tenMinsPassed():
    if (datetime.datetime.now() - startTime).total_seconds() >= 599:
        return True
    else: return False

while True:
    limit+=1
    if tenMinsPassed():
        limit = 0
    if limit < 9000 and not tenMinsPassed():
        makeLoot()
        r = random.randint(1,2)
        time.sleep(r)
    else: 
        print("current requests {limit} and 10 mins reached")
        print("Wating the remainder time to restart")
        waitTime = (datetime.datetime.now()-startTime).total_seconds() - 599
        time.sleep(waitTime)

        # Resetting startTime 
        startTime = datetime.datetime.now()
        continue


# findPosition()