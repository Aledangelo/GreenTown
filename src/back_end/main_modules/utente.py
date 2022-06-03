import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from db_modules.my_sql.connector import dbSql

class utente():
    def __init__(self) -> None:
        pass

    def registrazione(self, nome: str, cognome: str, city: str, email: str, password: str, phone: str, age: str, token: str):
        res = dbSql.insertAccount(nome, cognome, city, email, password, phone, age, token)


    def login(self, id: str, token: str, tipo: str, table: str):
        dbSql.insertToken(id, token, tipo, table)

    def logout(self, table_l: str, table_v: str, table: str):
        dbSql.deleteRowByParam(table_l, table_v, table)

    #per ora sta qua
    def senderEmail(self, rec_address: str, sixDigitCode: str):
        mail_content = "Benvenuto in GreenTown,\nl'app che ti permette di contribuire alla salvaguardia del tuo territorio.\n" \
                       "Manca un ultimo passaggio per confermare il tuo account.\nInserisci il codice di verifica " \
                       "sull'app: \n\n" + sixDigitCode

        # Indirizzi email e password
        sender_address = "GreenTownValidator@gmail.com"
        sender_pass = "joXro8-fatgem-faxris"
        receiver_address = str(rec_address)

        # Setup MIME
        msg = MIMEMultipart()
        msg['From'] = sender_address
        msg['To'] = receiver_address
        msg['Subject'] = "Conferma il tuo Account"

        # Body dell'email
        msg.attach(MIMEText(mail_content, 'plain'))

        # Creo una sessione SMTP col server di gmail
        session = smtplib.SMTP(host='smtp.gmail.com', port=587)
        session.starttls()  # enable security
        session.login(sender_address, sender_pass)
        text = msg.as_string()
        session.sendmail(sender_address, receiver_address, text)
        session.quit()
        return

if __name__ == '__main__':
    u = utente()
    u.registrazione('giovanni','esposito','virginia' ,'ciao@ciao.com', 'ciao', '1234567', '10/10/10', str(123456))

