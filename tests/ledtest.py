#!/usr/bin/env python

import serial
import array
import time
import math

# Arduino in the box
serialport = '/dev/ttyUSB0'
# Development Arduino
#serialport = '/dev/tty.usbmodemfa141'

ready = False
ser = serial.Serial(serialport, 57600)
time.sleep(1)
while True:
    if ser.inWaiting() > 0:
        incoming = ser.readline()
        print incoming,
        if "Hello LightEngine" in incoming: ready = True

    if ready:
        t = time.time();
        values = [0xff];
        for i in range(30):
            normval = (math.sin(t*2+i*360/16*math.pi/180) + 1)/2
#            normval = (math.sin(t/2+0*360/16*math.pi/180) + 1)/2
            squeezed = normval * 0.8 + 0.2
            expval = math.pow(squeezed, 1.75)
            values.append(int(expval * 127))
        print(values)
        data = array.array('B', values).tostring()
        ser.write(data)
        time.sleep(0.1)
#        time.sleep(0.5)
