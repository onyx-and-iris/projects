import os
import runnersjson
import pickle
import json

from flask import (
                Flask, 
                render_template, 
                request, 
                escape,
                session
                )
from dblog import ConnectDB
from checker import check_logged_in

app = Flask(__name__)

app.config['dbconfig'] = {}

app.secret_key = os.environ.get('SECRET_KEY')

def log_request(req: 'flask_request', res: str) -> None:
    """ using loopback/req.remote_addr """
    with ConnectDB(app.config['dbconfig']) as cursor:
        _SQL = """
            insert into log
            (shortname, ip, browser_string, data)
            values
            (%s, %s, %s, %s) """
        _DATA = (
            req.form['name'],
            '127.0.0.1',
            req.user_agent.browser,
            json.dumps(res),)

        cursor.execute(_SQL, _DATA)

@app.route('/worldrunner', methods=['POST'])
def get_record() -> 'html':
    """ get record from json return response html """
    name = request.form['name']
    outro = 'Thanks for using the World Runners Webapp!'
    
    records = runnersjson.Records()
    this_record = ((records.get_record_byname(name)))

    log_request(request, this_record)
    return render_template('results.html',
    the_name = this_record['name'],
    the_age = this_record['age'],
    the_country = this_record['country'],
    the_event = this_record['event'],
    the_pb = this_record['pb'],
    the_outro = outro,)

@app.route('/')
@app.route('/search')
def entry_page() -> 'html':
    """ load entry.html on action run worldrunner """
    return render_template('search.html',
    the_title='Welcome to World Runners Webapp!')


@app.route('/viewlog')
@check_logged_in
def view_log() -> 'html':
    """ create a list of lists and assign to jinja2 vars """
    with ConnectDB(app.config['dbconfig']) as cursor:
        _SQL = """
            select shortname, ip, browser_string, data
            from log """
        cursor.execute(_SQL)
        res = cursor.fetchall()
   
    titles = ('Query', 'IP Addr', 'Browser', 'Data')
    return render_template('viewlog.html',
                            the_title='View Log',
                            the_row_titles=titles,
                            the_data=res,)

@app.route('/login')
def do_login() -> str:
    session['logged_in'] = True
    return 'Logged In'

@app.route('/logout')
def do_logout():
    session.pop('logged_in')
    return 'Logged out'


if __name__ == '__main__':
    token = 'token.pkl'

    try:
        with open(token, 'rb') as tokenfile:
            app.config['dbconfig'] = pickle.load(tokenfile)
    except (FileNotFoundError, EOFError):
        app.config['dbconfig']['host'] = input('IP address: ')
        app.config['dbconfig']['user'] = input('DB Username: ')
        app.config['dbconfig']['password'] = input('DB password: ')
        app.config['dbconfig']['database'] = input('DB name: ')

        with open(token, 'wb') as tokenfile:
            pickle.dump(app.config['dbconfig'], tokenfile)

    app.run(host='0.0.0.0', port=5001, debug=True)

