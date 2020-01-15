import pyodbc 
import os
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port

print("SERVER STARTUP!")

server = 'tcp:' + str(os.getenv('SQL_SERVER'))
database = str(os.getenv('SQL_DB'))
username = str(os.getenv('SQL_USER')) 
password = str(os.getenv('SQL_PASS'))
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

cursor.execute('SELECT * FROM first_table')
rows = cursor.fetchall()

for row in rows:
    print(row)




print("SERVER END")