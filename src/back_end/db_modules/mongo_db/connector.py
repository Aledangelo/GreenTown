import db_modules.mongo_db.mongoDb as mongo

__host = 'GreenTeam:eyRukWH7hNC99nu@cluster0.kthtk.mongodb.net/'
__database = 'GreenTown-mongo'

dbMongo = mongo.MongoDb(__host, __database)
dbMongo.connect()
