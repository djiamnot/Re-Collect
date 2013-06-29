#!/usr/bin/env python

import serial

port = "/dev/ttyUSB0"
s = serial.Serial(port, 57600)

while(True):
    print(s.readline())
