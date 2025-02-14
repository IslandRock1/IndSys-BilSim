
from math import atan, sqrt, acos, tau

def boundNormalize(v):
    return min(1, max(-1, v))

def computeAngles(roll, pitch):
    delta = 0.08

    s0, s1 = 1, 1
    r, p = roll, pitch

    l = 1.75

    tmp = l / 2 * atan(p / s1)
    p1 = delta + tmp
    p0 = delta - tmp

    p2 = delta - (l * sqrt(3) / 2) * atan(r / s0)

    print(f"Heights: {p0, p1, p2}")

    # acos is limited to acos(x), x in [-1, 1]
    a0 = acos(boundNormalize(- (p0 - delta) / delta))
    a1 = acos(boundNormalize(- (p1 - delta) / delta))
    a2 = acos(boundNormalize(- (p2 - delta) / delta))

    deg = lambda a : a * 360.0 / tau

    return (a0, a1, a2), (deg(a0), deg(a1), deg(a2))

rad = lambda a : (a / 360) * tau
roll = 3.0 # Deg
pitch = 5.25 # Deg

rads, degs = computeAngles(rad(roll), rad(pitch))
print(f"Degs: {degs[0]} | {degs[1]} | {degs[2]}")
