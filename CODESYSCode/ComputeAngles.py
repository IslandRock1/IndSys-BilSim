
from math import atan, sqrt, acos, tau, sin
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches

from tqdm import tqdm
from time import perf_counter

deg = lambda a : a * 360.0 / tau
rad = lambda a : (a / 360) * tau

def boundNormalize(v):
    didBound = False
    if (v > 1):
        v = 1
        didBound = True
    
    if (v < -1):
        v = -1
        didBound = True

    return v, didBound

def computeAngles(roll, pitch):
    delta = 0.08

    s0, s1 = 1, 1
    r, p = roll, pitch

    l = 1.75

    tmp = l / 2 * sin(r / s1)
    p1 = delta + tmp
    p0 = delta - tmp


    tmp = sin(-p / s0) / 2.0
    p2 = delta - tmp * (l * sqrt(3))

    p0 += tmp * (l * sqrt(3) / 6)
    p1 += tmp * (l * sqrt(3) / 6)

    # print(f"Heights: {p0, p1, p2}")

    p0, didBound0 = boundNormalize(- (p0 - delta) / delta)
    p1, didBound1 = boundNormalize(- (p1 - delta) / delta)
    p2, didBound2 = boundNormalize(- (p2 - delta) / delta)
    didBound = (didBound0 or didBound1 or didBound2)
    # acos is limited to acos(x), x in [-1, 1]
    a0 = acos(p0)
    a1 = acos(p1)
    a2 = acos(p2)

    return (a0, a1, a2), (deg(a0), deg(a1), deg(a2)), didBound

def testFunc():
    roll = 10.0 # Deg
    pitch = -6.0 # Deg

    rads, degs, didBound = computeAngles(rad(roll), rad(pitch))
    print(f"Degs: {degs[0]} | {degs[1]} | {degs[2]}. didBound: {didBound}")

def findFuncLimits():
    outPut = []

    size = 6.5
    numPoints = 1000

    notBounded = 0
    isBounded = 0

    with tqdm(total=numPoints, desc="Processing") as pbar:
        for i, r in enumerate(np.linspace(-size, size, numPoints)):
            pbar.n = i  # Sum all progress values
            pbar.refresh()
            
            out = []
            for p in np.linspace(-size, size, numPoints):
                _, _, didBound = computeAngles(rad(r), rad(p))
                out.append(int(didBound))

                if didBound:
                    isBounded += 1
                else:
                    notBounded += 1

            outPut.append(out)
    
    print()
    print(f"{notBounded = } | {isBounded = }")
    plt.imshow(outPut, interpolation='none', cmap="viridis")

    true_patch = mpatches.Patch(color=plt.cm.viridis(1.0), label="Impossible")   # Yellow
    false_patch = mpatches.Patch(color=plt.cm.viridis(0.0), label="Possible")  # Purple

    # Add legend
    plt.legend(handles=[true_patch, false_patch], loc="upper right")

    ticks = list(np.linspace(0, numPoints, 8))
    values = np.round(np.array(np.linspace(-size, size, 8)), 2)

    plt.title("Physicly possible roll and pitch for outer hole on motor fastener")


    plt.xticks(ticks=ticks, labels=values)
    plt.yticks(ticks=ticks, labels=values)

    plt.ylabel("Roll")
    plt.xlabel("Pitch")
    plt.show()

def timeFunc():

    numPoints = 100
    size = 0.113446401

    t0 = perf_counter()
    for pitch in np.linspace(-size, size, numPoints):
        for roll in np.linspace(-size, size, numPoints):
            computeAngles(roll, pitch)
    t1 = perf_counter()
    print(f"Time: {t1 - t0} seconds. Per call: {1000000 * (t1 - t0) / numPoints ** 2} us")

#testFunc()
findFuncLimits()
# timeFunc()