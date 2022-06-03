from datetime import datetime
from flask import Flask
from flask import request, jsonify
import sys
from secrets import token_hex

from email_validator import validate_email, EmailNotValidError

sys.path.insert(1,'/home/ubuntu/GreenTown/src/back_end')
import support_modules.utils as utils
import main_modules.reports as rep
import main_modules.utente as us

from db_modules.my_sql.connector import dbSql

import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from flask import render_template

app = Flask(__name__)

host = "localhost"
user = "root"
password_db = ""
dbname = "green"





@app.route('/user/checkEmail', methods=["POST"])
def checkEmail():
    json_data = request.json
    code = json_data['email']

    auth = utils.Auth(str(code), "", "valid", "greenaccount")
    v = auth.validateEmail()
    if v:
        return jsonify({
            "status": "success"
        }
        ), 200
    else:
        return jsonify({
            "status": "fail"
        }
        ), 400


@app.route('/user/Registration', methods=["POST"])
def registration_page():
    form = request.json 
    name = form["nome"] 
    surname = form["cognome"] 
    city = form["citta"]
    email = form["email_r"]
    cell = form["cell"]
    birthdate = form["data"]
    password = form["password"] 

    c = utils.VerifyInput()
    var = c.checkEmpty(name, surname, city, password)

    if not var:
        return jsonify({
            "status": "notValidInput"
        }
        ), 402

    var = c.checkEmail(email)
    if not var:
        return jsonify({
            "status": "notValidMail"
        }
        ), 401

    auth = utils.Auth(email, "", "email", "greenaccount")

    verify = auth.verifyGeneric()

    if verify:
        sixDigitCode = token_hex(3)
        u = us.utente()
        u.registrazione(name, surname, city, email, password, cell, birthdate, str(sixDigitCode))
        u.senderEmail(email, sixDigitCode)
        return jsonify({
            "status": "success"
        }
        ), 200
    else:
        return jsonify({
            "status": "notValid"
        }
        ), 400


@app.route('/user/checkToken', methods=["GET"])
def checkToken():
    token = request.headers['X-API-Key']

    auth = utils.Auth(token, "", "token", "session")

    res = auth.verifyGeneric()

    if not res:
        lista = auth.multiSelect2()
        id = lista['id']
        userType = lista['userType']
        if userType == "usr":
            auth1 = utils.Auth(id, "", "id", "greenaccount")
            res1 = auth1.multiSelect2()
            return jsonify({
                "status": "success",
                "id": res1["id"],
                "name": res1["nome"],
                "cognome": res1["cognome"],
                "città": res1["citta"],
                "email": res1["email"],
                "cell": res1["cellulare"],
                "age": res1["nascita"],
                "userType": userType
            }), 200
        else:
            auth1 = utils.Auth(id, "", "id", "dipendenti")
            res1 = auth1.multiSelect2()
            return jsonify({
                "status": "success",
                "id": res1["id"],
                "username": res1["username"],
                "userType": userType,
                "cityId":res1['cityId']
            }), 200
    else:
        return jsonify({
            "status": "fail"
        }
        ), 401


@app.route('/user/login', methods=["POST"])
def login():
    json_data = request.json
    email = json_data["email"]
    password = json_data["password"]
    userType = json_data["userType"]

    if userType == "usr":
        auth = utils.Auth(email, "", "email", "greenaccount")
    else:
        auth = utils.Auth(email, "", "username", "dipendenti")

    checkPass = auth.multiSelect1()
    if checkPass != "" and checkPass == password:
        lista = auth.multiSelect2()
        usr_id = lista["id"]
        if userType == "usr":
            valid = lista["valid"]
            if valid != "yes":
                return jsonify({"status":"wait confirm"}),300
        token = token_hex(16)

        u = us.utente()
        u.login(usr_id, token, userType, "session")

        if userType == 'emp':
            return jsonify({
            "status": "success",
            "token": str(token)
        }), 200

        return jsonify({
            "status": "success",
            "token": str(token)
        }), 200

    else:
        msg = {"status": "Fail"}
        return jsonify(msg), 400


@app.route('/user/logout', methods=["GET"])
def logout():
    token = request.headers['X-API-Key']

    auth = utils.Auth(token, "", "token", "session")

    row_count = auth.verifyGeneric()

    if row_count:
        msg = {"status": "fail"}
        return jsonify(msg), 400
    else:
        u = us.utente()
        u.logout("token", token, "session")
        msg = {"status": "success"}
        return jsonify(msg), 201


@app.route('/reports/<cityId>', methods=['GET'])
def getReports(cityId):
    try:
        userId = request.headers['userId']
        apiKey = request.headers['X-API-Key']
        userType = request.headers["userType"]
        auth = utils.Auth(apiKey, userId, 'token', 'session')
        
        if not auth.verify():
            return 'Your key (or client id) is wrong', 401

        r = rep.Reports()
        if userType == 'usr':
            dataResp = r.getReportsByCity(int(cityId))
            dataResp = r.filterReportsByStatus(dataResp, 'si')
            return jsonify(dataResp), 200
        else:
            query =  request.args.get('status')
            if query == 'si':
                dataResp = r.getReportsByCity(int(cityId))
                dataResp = r.filterReportsByStatus(dataResp, 'si')
                return jsonify(dataResp), 200
            else:
                dataResp = r.getReportsByCity(int(cityId))
                dataResp = r.filterReportsByStatus(dataResp, 'no')
                return jsonify(dataResp), 200
    except:
        return 'Something went wrong', 400


@app.route('/reports', methods=['POST'])
def postReports():
    try:
        userId = request.headers['userId']
        apiKey = request.headers['X-API-Key']
        auth = utils.Auth(apiKey, userId, 'token', 'session')
        if not auth.verify():
            return 'Your key (or client id) is wrong', 401

        data = request.get_json()

        ut = utils.UtilsInput('reports')
        if not ut.checkKeys(data):
            return 'Bad input request', 400

        if not ut.checkValues(data):
            return 'Bad input request', 400

        images = data['images']
        if not ut.checkImages(images):
            return 'Bad input request', 400

        r = rep.Reports()
        result = r.postReport(data)
        if not result:
            return 'Bad input request', 400
        return "created", 201
    except:
        return 'Something went wrong',400

@app.route('/reports/destroy/<reportId>', methods=['DELETE'])
def destroy(reportId):
    userId = request.headers['userId']
    apiKey = request.headers['X-API-Key']
    auth = utils.Auth(apiKey, userId, 'token', 'session')
    if not auth.verify():
        return 'Your key (or client id) is wrong', 401

    r = rep.Reports()
    result = r.destroyReportById(reportId)
    if not result:
        return "Something went wrong",400
    return "deleted",200    

@app.route('/reports/approva/<reportId>', methods=['PATCH'])
def approve(reportId):
    userId = request.headers['userId']
    apiKey = request.headers['X-API-Key']
    auth = utils.Auth(apiKey, userId, 'token', 'session')
    if not auth.verify():
        return 'Your key (or client id) is wrong', 401
    r = rep.Reports()
    result = r.approveReportById(reportId)
    if not result:
        return "Something went wrong",400
    return "approved",200    


@app.route('/docApi' , methods=['GET'])
def docApi():
    return  render_template("api_v1.html")


if __name__=='__main__':
    app.run()
