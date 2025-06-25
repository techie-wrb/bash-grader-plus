from flask import Flask, render_template, request
import os
import subprocess
import uuid

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    files = request.files['codefile']
    if not files:
        return "No files uploaded", 400

    filename = f"{uuid.uuid4()}_{file.filename}"
    filepath = os.path.join(UPLOAD_FOLDER, filename)
    file.save(filepath)

    subprocess.run(['cp', filepath, '../grader/submissions/'])

    subprocess.run(['bash', '../grader/grade.sh'])

    with open('../grader/results/report.csv') as f:
        lines = f.readlines()[1:]
        last = lines[-1].strip().split(',')

    return render_template('result.html', student=last[0], score=last[1], remarks=last[2])

if __name__ == '__main__':
    app.run(debug=True)
