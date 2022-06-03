import collections
from typing import Collection
from db_modules.mongo_db.connector import dbMongo

class Reports():
    def __init__(self) -> None:
        pass

    def getReportsByCity(self, cityId: int) -> list:
        paramKey = 'cityId'
        collection = 'reports'
        result = dbMongo.getDocumentsByParam(paramKey, cityId, collection)
        resLst = []
        for r in result:
            r['_id'] =  str(r['_id'])
            resLst.append(r)
        return resLst
    
    def filterReportsByStatus(self, reports: list ,  status: str)-> list:
        lst = []
        for d in reports:
            if d['status'] == status:
                lst.append(d)
        return lst

    def destroyReportById(self, objectId: str) -> bool:
        collection = 'reports'
        result = dbMongo.deleteDocumentById(objectId, collection)
        if result == None:
            return False
        return True

    def approveReportById(self, objectId: str) -> bool:
        collection = 'reports'
        param = 'status'
        value = 'si'
        result = dbMongo.changeDocumentParamById(objectId, collection, param, value)
        if result == None:
            return False
        return True

    def postReport(self, data: dict) -> bool:
        collection = 'reports'
        data['cityId'] = int(data['cityId'])
        data['status'] = 'no'
        result = dbMongo.postDocument(data, collection)
        if result == None: 
            return False
        return True

if __name__=='__main__':
    r = Reports()
    print(r.getReportsByCity(80133))
