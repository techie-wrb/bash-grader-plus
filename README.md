# Bash Grader+

 A smart, interactive auto-grading web app for C/C++ programs using Bash, Flask, and SQLite. Easily upload code files, auto-grade them using test cases, view scores, and track results on a live leaderboard.

![Badge](https://img.shields.io/badge/Python-3.10-blue?style=flat)
![Badge](https://img.shields.io/badge/Made%20With-Flask-orange?style=flat)
![Badge](https://img.shields.io/badge/Auto-Grading-Green?style=flat)

---

## Features

-  **Upload C/C++ code** (single or multiple files)
- **Auto-run test cases** using Bash script
-  **Score calculation & remarks**
-  **Live leaderboard** with search & sort
-  **Auto-delete old submissions**
-  **Dark Mode Toggle**
-  **SQLite3 database** to store results
-  Clean, responsive Bootstrap UI

---

## ech Stack

- **Frontend:** HTML5, CSS3, Bootstrap 5
- **Backend:** Python 3, Flask
- **Scripting:** Bash
- **Database:** SQLite

---

## Setup Instructions

1. **Clone the Repository:**

```bash
git clone git@github.com:techie-wrb/bash-grader-plus.git
cd bash-grader-plus

2. Set up Virtual Environment:
   ```bash
    python3 -m venv venv
source venv/bin/activate
pip install flask

3. Run the Flask App:
   ```bash 
   python app.py
 
Then open http://127.0.0.1:5000/ in your browser 

Directory Structure
```pgsql
  bash-grader-plus/
├── app.py
├── templates/
│   ├── index.html
│   └── result.html
│   └── leaderboard.html
├── grader/
│   ├── grade.sh
│   ├── test_cases/
│   └── results/
├── submissions/
├── uploads/
├── leaderboard.db
└── README.md

Sample Test Case Format
test_cases/input1.txt
```txt
   5 10

test_cases/output1.txt
```txt
15

Author - Aman bijarnia 

Acknowledgements
Flask

Bootstrap

SQLite

StackOverflow
