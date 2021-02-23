import runners

from flask import Flask, render_template, request


app = Flask(__name__)

@app.route('/worldrunner', methods=['POST'])
def get_record() -> 'html':
    """ get record from pkl return response html """
    name = request.form['name']
    outro = 'Thanks for using the World Runners Webapp!'
    
    record = runners.Records()
    this_record = ((record.get_record_byname(name)))

    return render_template('results.html',
    the_name = this_record['name'],
    the_age = this_record['age'],
    the_country = this_record['country'],
    the_event = this_record['event'],
    the_pb = this_record['pb'],
    the_outro = outro,)

@app.route('/search')
def entry_page() -> 'html':
    """ load entry.html on action run worldrunner """
    return render_template('search.html',
    the_title='Welcome to World Runners Webapp!')


app.run(host='0.0.0.0', port=5001, debug=True)

