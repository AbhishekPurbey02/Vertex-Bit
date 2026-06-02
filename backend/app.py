from flask import Flask, request, jsonify
from flask_cors import CORS
import psycopg2
import psycopg2.extras
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)  # This allows your Flutter app to talk to this backend

# Database connection (will use environment variable on Render)
DATABASE_URL = os.environ.get('DATABASE_URL', 'postgresql://localhost:5432/vertexbit')

def get_db_connection():
    conn = psycopg2.connect(DATABASE_URL)
    return conn

# Create table if not exists
def init_db():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('''
        CREATE TABLE IF NOT EXISTS contacts (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) NOT NULL,
            phone VARCHAR(20) NOT NULL,
            subject VARCHAR(200),
            message TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    conn.commit()
    cur.close()
    conn.close()
    print("Database initialized successfully!")

# Health check endpoint
@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok', 'message': 'Vertex Bit API is running!'})

# Contact form endpoint
@app.route('/api/contact', methods=['POST'])
def contact():
    try:
        data = request.get_json()
        
        name = data.get('name')
        email = data.get('email')
        phone = data.get('phone')
        subject = data.get('subject', 'General Inquiry')
        message = data.get('message')
        
        # Validation
        if not name or not email or not phone or not message:
            return jsonify({'error': 'All fields are required'}), 400
        
        # Save to database
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('''
            INSERT INTO contacts (name, email, phone, subject, message, created_at)
            VALUES (%s, %s, %s, %s, %s, %s)
        ''', (name, email, phone, subject, message, datetime.now()))
        conn.commit()
        cur.close()
        conn.close()
        
        return jsonify({
            'success': True,
            'message': 'Thank you! We will contact you soon.'
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

# Get all contacts (for admin dashboard later)
@app.route('/api/contacts', methods=['GET'])
def get_contacts():
    try:
        conn = get_db_connection()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute('SELECT * FROM contacts ORDER BY created_at DESC')
        contacts = [dict(row) for row in cur.fetchall()]
        cur.close()
        conn.close()
        return jsonify(contacts), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    init_db()
    app.run(debug=True, port=5000)