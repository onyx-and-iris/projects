import runnersjson
import pickle

from flask import Flask, render_template, request, escape

app = Flask(__name__)

def log_request(req: 'flask_request', res: str) -> None:
    """ using loopback/req.remote_addr """
    logfile = 'records.log'
    with open(logfile, 'a') as log:
        print(
        req.form,
        '127.0.0.1',
        req.user_agent,
        res, file=log, sep='|')

@app.route('/worldrunner', methods=['POST'])
def get_record() -> 'html':
    """ get record from json return response html """
    name = request.form['name']
    outro = 'Thanks for using the World Runners Webapp!'
    
    record = runnersjson.Records()
    this_record = ((record.get_record_byname(name)))

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
def view_log() -> 'html':
    """ create a list of lists and assign to jinja2 vars """
    data = []
    with open('records.log') as log:
        for line in log:
            data.append([])
            for item in line.split('|'):
                data[-1].append(escape(item))
    
    titles = ('Form Data', 'IP Addr', 'User_agent', 'Results')
    return render_template('viewlog.html',
                            the_title='View Log',
                            the_row_title=titles,
                            the_data=data,)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)

