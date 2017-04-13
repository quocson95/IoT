#!/usr/bin/env python
# -*- coding: utf8 -*-

import RPi.GPIO as GPIO
import MFRC522
import signal
import time
import sys
reload(sys) 
sys.setdefaultencoding("utf-8")
import unicodedata
from PyQt5.QtCore import QThread, QObject, pyqtSignal

class getPostsThread(QThread):

    add_uid =  pyqtSignal(str)
    add_memory = pyqtSignal(str)
    add_mssv = pyqtSignal(str)
    add_khoa = pyqtSignal(str)
    def __init__(self):
        QThread.__init__(self)
    def __del__(self):
        self.wait()
    def run(self):
        read_card(self)
        #self.sleep(2)

def getStr(text,posi):
    str_return = ""
    while (posi < len(text) - 1):
        if (text[posi] != ","):
            if (text[posi] != " "): str_return += text[posi]
            posi = posi + 1
        else: return (str_return,posi)
    return (str_return,posi)
def encodeStr(text):
    print "Encode"
    lentext = len(text)
    posi = 1
    str_int = 1;
    while posi < len(text) - 1:
        (get_str,posi) = getStr(text,posi)
        str_int = int(get_str)
        # print get_str.encode('ascii')
        # print get_str.encode(encoding='UTF-8',errors='strict')
        print str((str_int))
        posi = posi + 1
        # print get_str
def encostring(text):
        i = 0;
        stri = "";
        while (i < len(text)):
            print  text[i].encode('utf-8')
            i = i+1
        # print str(stri);

def getMSSV(text):
    print "Get MSSV"
    startGetMssv = False
    lentext = len(text)
    posi = 1
    mssv = ""
    while posi < len(text) - 1:
        (get_str,posi) = getStr(text,posi)
        if (get_str == "8" ): startGetMssv = True
    	else :
	        if (startGetMssv == True): mssv += chr(int(get_str));
	        if (get_str == "9"):
	        	print mssv
	        	return mssv
        posi += 1

def getKhoa(text):
    print "Get Khoa"
    startGetKhoa = False
    lentext = len(text)
    posi = 1
    khoa = ""
    while posi < len(text) - 1:
        (get_str,posi) = getStr(text,posi)
        if (get_str == "2" ): startGetKhoa = True
    	else :
    		if (get_str == "6"):
	        	print khoa
	        	return khoa
	        if (startGetKhoa == True): khoa += chr(int(get_str));
        posi += 1

def getCTDT(text):
    print "Get CTCT"
    startGetCT = False
    startGetHe = False
    ct = ""
    he = ""
    lentext = len(text)
    posi = 1
    khoa = ""
    while posi < len(text) - 1:
    	print startGetCT
        (get_str,posi) = getStr(text,posi)
        if (get_str == "2" ):
            if (startGetCT == False): startGetCT = True
            else: startGetHe = True;
    	else :
    		if (startGetHe == True):
        		he += chr(int(get_str));
	        elif (startGetCT == True): ct += chr(int(get_str));
        posi += 1
    print "CT " + ct
    print "He " + he
def end_read(signal,frame):
        global continue_reading
        print "Ctrl+C captured, ending read."
        continue_reading = False
        GPIO.cleanup()
def read_card(self):
    GPIO.cleanup()
    continue_reading = True
    # Capture SIGINT for cleanup when the script is aborted

    # Hook the SIGINT
    #signal.signal(signal.SIGINT, end_read)

    # Create an object of the class MFRC522
    MIFAREReader = MFRC522.MFRC522()
    # Welcome message
    print "Welcome to the MFRC522 data read example"
    print "Press Ctrl-C to stop."

    # This loop keeps checking for chips. If one is near it will get the UID and authenticate

    reading = 0
    post_uid = " "
    post_memory = ""
    #ui.setUuid("trhead")
    while continue_reading:
        
        # Scan for cards    
        (status,TagType) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)

        # If a card is found
        if status == MIFAREReader.MI_OK:
            print "Card detected"
            reading = 1;
            # Get the UID of the card
            (status,uid) = MIFAREReader.MFRC522_Anticoll()

            # If we have the UID, continue
            if status == MIFAREReader.MI_OK:
                post_uid = ""
                post_uid = str(uid[0])+","+str(uid[1])+","+str(uid[2])+","+str(uid[3])
                # Print UID
                print "Card read UID: " + str(post_uid)
                #send signal to display uid
                self.add_uid.emit(post_uid)
                # This is the default key for authentication
                key = [0xFF,0xFF,0xFF,0xFF,0xFF,0xFF]
                
                # Select the scanned tag
                MIFAREReader.MFRC522_SelectTag(uid)

                # Authenticate
                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,16 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(16);
                    self.add_mssv.emit(getMSSV(post_memory))
                    # encodeStr(post_memory
                    # post_memory = MIFAREReader.MFRC522_Read(17);
                    # # encodeStr(post_memory)
                    # print post_memory

                    # post_memory = MIFAREReader.MFRC522_Read(18);
                    # # encodeStr(post_memory)
                    # print post_memory

                    # post_memory = MIFAREReader.MFRC522_Read(20);
                    # # encodeStr(post_memory)
                    # print post_memory
                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,17 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(17);
                    
                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,18 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(18);
                    self.add_khoa.emit(getKhoa(post_memory))
                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,19 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(19);
                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,20 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(20);
                    getCTDT(post_memory);

                status = MIFAREReader.MFRC522_Auth(MIFAREReader.PICC_AUTHENT1A,21 , key, uid)
                # Check if authenticated
                if status == MIFAREReader.MI_OK:
                    post_memory = MIFAREReader.MFRC522_Read(21);
                    
                else:
                    print "Authentication error"
                self.add_memory.emit(post_memory)

                MIFAREReader.MFRC522_StopCrypto1()

                
                

        #Holding while pull off card
        elif reading == 1:
            count = 0
            while count < 5:
                (status,TagType) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)
                count = count + 1
                if status == 0: count = 0
                if count > 4: reading = 0

        print "Start new Card : %s" % time.ctime()
        time.sleep(0.5)