#!/usr/bin/python
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtCore import QThread, QObject, pyqtSignal
from threading import Thread
import threading
from Read import *
import time
import sys
import design
import urllib2
import requests
import json
# class getPostsThread(QThread):

# 	add_post =  pyqtSignal(str)

# 	def __init__(self):
# 		QThread.__init__(self)
# 	def __del__(self):
# 		self.wait()
# 	def run(self):
# 		post = "post"
# 		self.add_post.emit(post)
# 		self.sleep(2)



class Threading(design.Ui_MainWindow):
	def __init__(self,MainWindow):
		super(self.__class__, self).__init__()
		self.setupUi(MainWindow)
	def dataCard(self):
		self.get_thread = getPostsThread()
		self.get_thread.add_uid.connect(self.setuuid)
		self.get_thread.add_memory.connect(self.setmemory)
		self.get_thread.add_mssv.connect(self.setMssv);
		self.get_thread.add_khoa.connect(self.setKhoa);
		#self.get_thread.connect(self.get_thread, SIGNAL("finished()"), self.done)
		self.get_thread.start()
	@QtCore.pyqtSlot()
	def setuuid(self,text):
		self.txt_uuid.setText(text)
	def setmemory(self,text):
		self.txt_memory.setText(text)
	def setMssv(self,text):
		self.txt_mssv.setText(text)
	def setKhoa(self,text):
		self.txt_khoa.setText(text)
	def done(self):
		QtGui.QMessageBox.information(self, "Done!", "Done fetching posts!")


class Payload(object):
	def __init__(self, j):
		self.__dict__ = json.loads(j)

class getDataFromServer(threading.Thread):
	def __init__(self,name,url):
		threading.Thread.__init__(self)
		self.url = url
		self.name = name
		self.threadID = "1"
	def run(self):
		print "Starting request "+self.url+" from "+self.name
		url = 'https://api.backand.com/1/query/data/Pi'
		headers = {'anonymoustoken': '551e6826-dadf-4851-9335-01bbf8203a7c'}
		r = requests.get(url, headers=headers)
		obj =  json.loads(r.text)
		a = r.json();
		print "Response request from "+self.name
		print type(a)
		# print a[0]['mssv']
		print a

def main():
	# app = QtWidgets.QApplication(sys.argv)
	# MainWindow = QtWidgets.QMainWindow()
	# form = Threading(MainWindow)
	# form.dataCard()
	# MainWindow.show()
	# sys.exit(app.exec_())
	# j = '{"action": "print", "method": "onData", "data": "Madan Mohan"}'
	# url = 'https://api.backand.com/1/query/data/Pi'
	# headers = {'anonymoustoken': '551e6826-dadf-4851-9335-01bbf8203a7c'}
	# r = requests.get(url, headers=headers)
	# obj =  json.loads(r.text)
	# a = r.json();
	# print type(a)
	# print a[0]['mssv']
	threads = []
	thread1 = getDataFromServer("thread example 1","https://api.backand.com/1/query/data/Pi")
	thread2 = getDataFromServer("thread example 2 ","https://api.backand.com/2/query/data/Pi")
	thread3 = getDataFromServer("thread example 3","https://api.backand.com/3/query/data/Pi")
	thread1.start()
	thread2.start()
	thread3.start()

	threads.append(thread1)
	threads.append(thread1)
	threads.append(thread1)
	print "waiting for  thread"
	for t in threads:
		t.join()
	print "Exiting Main Thread"

if __name__ == '__main__':
	main()

