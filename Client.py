#! /usr/bin/python
import sys
import socket
import threading
import time
# Creat a TCP/IP socket


def recv_timeout(the_socket,timeout=2):
    #make socket non blocking
    the_socket.setblocking(0)
     
    #total data partwise in an array
    total_data=[];
    data='';
     
    #beginning time
    begin=time.time()
    while 1:
        #if you got some data, then break after timeout
        if total_data and time.time()-begin > timeout:
            break
         
        #if you got no data at all, wait a little longer, twice the timeout
        elif time.time()-begin > timeout*2:
            break
         
        #recv something
        try:
            data = the_socket.recv(8192)
            if data:
                total_data.append(data)
                #change the beginning time for measurement
                begin=time.time()
            else:
                #sleep for sometime to indicate a gap
                time.sleep(0.1)
        except:
            pass
     
    #join all parts to make final string
    return ''.join(total_data)
class ClientThreading(threading.Thread):
	def __init__(seft,threadID,ip,port):
		threading.Thread.__init__(seft)
		seft.threadID = threadID
		seft.ip = ip;
		seft.port = port
		print '[+] New Thread  %s started %s for : %s' %(threadID,ip,port )
	def run(seft):
		sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
		#Bind the socket to the port
		server_address = (seft.ip,seft.port)
		print >> sys.stderr,'Starting up on  %s port %s' %(seft.ip,seft.port)
		sock.connect(server_address)
		#get reply and print
		try:
			#send data
			message = 'This is message.It is important'
			print >> sys.stderr,'sending "%s" '%message
			sock.sendall(message)
			#Lock for the response
			print recv_timeout(sock)
		finally:
			print >>sys.stderr,'Closing socket from thread %s' %seft.threadID
			sock.close()

for i in range (1,10):
	newThread = ClientThreading(i,"192.168.1.65",2000)
	newThread.start();