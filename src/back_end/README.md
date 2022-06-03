# GreenTown Back-end

## Il back-end è diviso nei seguenti moduli:

### db_modules
Qui sono presenti altre due directory my_sql e mongo_db contenenti i moduli per l'accesso hai rispettivi database

my_sql: 
* mySql.py -> contiene una classe per l'accesso e le query a MySql
* connector.py -> script che istanzia un oggetto della classe MySql ed effettua la connessione

Per usare la classe basta importare il modulo connector.py e utilizzare l'oggetto dbSql già in esso istanziato. 

Esempio:
    from db_modules.my_sql.connector import dbSql
    dbSql.selectRowByParam(paramKey, paramValue, table)
Dove paramKey è il nome della colonna su cui effettuare la ricerca, paramValue è il valore che si vuole cercare e table è il nome della tabella

mongo_db:
* mongoDb.py -> contiene una classe per l'accesso e le query a MongoDb
* connector.py -> script che istanzia un oggetto della classe MongoDb ed effettua la connessione

Per usare la classe basta importare il modulo connector.py e utilizzare l'oggetto dbMongo già in esso istanziato. 

Esempio:

    from db_modules.mongo_db.connector import dbMongo

    dbMongo.getDocumentsByParam(paramKey, paramValue, collection)
Dove paramKey è il nome della colonna su cui effettuare la ricerca, paramValue è il valore che si vuole cercare e collection è il nome della collection (stessa cosa della tabella di MySql)

ATTENZIONE: Questi oggetti non conviene utilizzarli in router.py bensì conviene usare classi intermedie che li utilizzano definite magari in un'altra directory -> main_modules

### main_modules
Qui per ora è presente il modulo reports.py (e login.py vuoto) che utilizza i moduli del db. 
In generale per ogni caso d'uso (circa) converebbe creare una classe apposita che gestisce il caso d'uso (e usa i moduli per il db se necessario)
Dunque ad esempio per il login si potrebbe creare una classe Login con dei metodi opportuni (ad esempio effettua login ed effettua logout), o alternativamente si potrebbe pensare di creare una classe User per gestire login e registrazione...

### support_modules
Qui è presente il modulo utils.py che contiene semplicemente delle classi di utilità ad esempio una classe Auth che serve per verificare che il token e l'userId sono corretti e una classe UtilsInput per verificare in generale che gli input inseriti siano corretti.
