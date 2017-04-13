import mysql.connector
def connect():
    """ Connect to MySQL database """
    try:
        conn = mysql.connector.connect(host='localhost',
                                       database='iot_database',
                                       user='root',
                                       password='raspberry')
        if conn.is_connected():
            print('Connected to MySQL database')
            return (True,conn)
        else :
        	print('Connected to MySQL failed')
        	return (False,conn)
    except:
    	print 'error while connect'
	return (False,conn)
def add_database():
	try:
		cursor = conn.cursor()
		cursor.execute("INSERT INTO board_info VALUES ('R101','raspberry','testing add','702H6')")
		conn.commit()
		print'Insert sucess'
	except:
		print'Error while insert'
	finally:
		cursor.close()
def query_with_fetchome():
	try:
		cursor = conn.cursor()
		cursor.execute("SELECT * FROM board_info")
		row = cursor.fetchone()
		while row is not None:
			print(row)
			row = cursor.fetchone()
	except:
		print'Error while fetching'
	finally:
		cursor.close()

if __name__ == '__main__':
	(status,conn) = connect()
	if (status): 
		#query_with_fetchome()
		add_database()
		conn.close()
