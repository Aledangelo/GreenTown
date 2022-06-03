from typing import Iterator
from pymongo import MongoClient
from bson.objectid import ObjectId


class MongoDb():
    def __init__(self, host: str, database: str, port: int = 27017) -> None:
        self.__host = host
        self.__database = database
        self.__port = port

    def connect(self) -> None:
        client  = MongoClient(f'mongodb+srv://{self.__host}',self.__port)  # Connect to mongodb
        self.__db = client[f'{self.__database}']
        #self.__db = client[self.__database]  # Create if doesn't exist a database and access to it

    def getDocumentsByParam(self, paramKey: str, paramValue: object, collection: str) -> Iterator:
        collect = self.__db[f'{collection}']
        result = collect.find({paramKey: paramValue})
        return result

    def postDocument(self, document: dict, collection: str) -> object:
        collect = self.__db[f'{collection}']
        objectId = collect.insert_one(document)
        return objectId
    
    def deleteDocumentById(self, id: str, collection: str) -> object:
        collect = self.__db[f'{collection}']
        result = collect.delete_one({'_id': ObjectId(id)})
        return result

    def changeDocumentParamById(self, id: str, collection: str, param: str, value: str) -> object:
        collect = self.__db[f'{collection}']
        result = collect.update_one({'_id' : ObjectId(id)}, { '$set': {f'{param}' : f'{value}'}})
        return result

"""GreenTown-mongo?retryWrites=true&w=majority"""


if __name__ == '__main__':
    mongo = MongoDb('GreenTeam:eyRukWH7hNC99nu@cluster0.kthtk.mongodb.net/', 'GreenTown-mongo')
    mongo.connect()
    res = mongo.getDocumentsByParam('cityId', 80133, 'reports')
    for r in res:
        print(r)
    print(res)

    # res = mongo.postDocument({'name':'vandalismo', 'description':'il totem fa il bullo', 'cityId':80133}, 'reports')
    # print(res)
