#! /usr/bin/env python

import subprocess
#import xml.dom.minidom
import xml.etree.ElementTree as ET

def get_info():
    xmldata = subprocess.check_output(["ioreg", "-c", "AppleSmartBattery", "-w0", "-a"])
    #data = minidom.parseString(xmldata)
    root = ET.fromstring(xmldata)
    dictionaries = root.findall(".//array/dict")
    for d in dictionaries:
        #print(d["AdapterInfo"])
        keys = d.findall(".//key")
        for k in keys:
            print(k.text)


def main():
    info = get_info()

main()
