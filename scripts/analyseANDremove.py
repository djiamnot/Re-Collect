#!/usr/bin/env python
import csv
import os
import re
import logging
import subprocess as sp

# DIR = "/home/mis/src/Re-Collect/snd"
DIR = "/home/mis/src/Re-Collect/snd"
DESTDIR = "/home/mis/src/Re-Collect/snd-reject"
FILES = []
#file = "/home/mis/src/Re-Collect/snd/20150421-10-57-21.wav"
file = ""
minAmp = 1600
maxAmp = 29000
logging.basicConfig(filename="/var/tmp/ReCollect.log", format='%(asctime)s %(message)s', level=logging.DEBUG)

def listFiles(dir):
    global FILES
    collection = []
    files = sp.check_output(["ls", dir])
    for f in files.split("\n"):
        absolute = os.path.join(DIR, f)
        if len(f) > 0:
            if os.stat(absolute).st_size < 100:
                os.remove(absolute)
                logging.debug("Removed {}".format(absolute))
            else:
                collection.append(absolute)
    return collection

def sndfile(dir):
    """Analyse files under dir and remove quiet files"""
    collection = listFiles(dir)
    collection = collection[:-1] # last entry is just the directory. FIXME?
    fileCount = 0
    for file in collection:
        try:
            snd = sp.check_output(["sndfile-info", file])
            infos = snd.split("\n")
            sig = [x for x in infos if "Signal Max" in x]
            sigData = sig[0].split(":")
            sigData = sigData[1].strip()
            sigData = sigData.split(" ")[0]
            loudness = int(sigData)
            # logging.debug("file: {} - loudness: {}".format(os.path.split(file)[1], loudness))
            if loudness < minAmp or loudness > maxAmp:
                filename = os.path.split(file)[1]
                logging.warning("-------> Removing file: {} with loudness {}".format(os.path.split(file)[1], loudness))
                os.rename(file, os.path.join(DESTDIR, filename))
        except sp.CalledProcessError:
            logging.error("error occured")
            pass
        fileCount += 1

if __name__ == "__main__":
    logging.info("Running analyser/remover")
    sndfile(DIR)
