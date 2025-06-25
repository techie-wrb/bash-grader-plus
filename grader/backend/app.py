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
    file = request.files['codefile']
    if not file:
        return "No file", 400

    filename = f"{uuid.uuid4()}_{file.filename}"
    filepath = os.path.join(UPLOAD_FOLDER, filename)
    file.save(filepath)

    # Move to grader
    subprocess.run(['cp', filepath, '../grader/submissions/'])

    # Run grader
    result = subprocess.run(['bash', '../grader/grade.sh'], capture_output=True, text=True)

    # Read results
    with open('../grader/results/report.csv') as f:
        lines = f.readlines()[1:]
        last = lines[-1].strip().split(',')

    return render_template('result.html', student=last[0], score=last[1], remarks=last[2])

if __name__ == '__main__':
    app.run(debug=True)
