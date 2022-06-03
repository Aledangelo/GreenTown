import db_modules.my_sql.mySql as sql

__host='database-1.cpmyqifdjztx.us-east-1.rds.amazonaws.com'
__user='admin'
__password='3dun9d840fwedec-ceosdcsi'
__port=3306
__database='green'

dbSql = sql.MySql(__host, __user, __password, __database, port=__port)
dbSql.connect()
