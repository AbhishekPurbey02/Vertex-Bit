from flask import Flask, request, jsonify
from flask_cors import CORS
import psycopg2
import psycopg2.extras
import os
from datetime import datetime
import urllib.parse

app = Flask(__name__)
CORS(app)

# Database connection
def get_db_connection():
    # Try environment variable first (for production), then local fallback
    database_url = os.environ.get('DATABASE_URL')
    
    if database_url:
        # For Render/Supabase
        return psycopg2.connect(database_url, sslmode='require')
    else:
        # Local PostgreSQL
        return psycopg2.connect(
            host='localhost',
            database='vertexbit',
            user='postgres',
            password='your_password_here'  # CHANGE THIS
        )

# Initialize database tables
def init_db():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        
        # Create contacts table
        cur.execute('''
            CREATE TABLE IF NOT EXISTS contacts (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                email VARCHAR(100) NOT NULL,
                phone VARCHAR(20) NOT NULL,
                subject VARCHAR(200),
                message TEXT NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                is_read BOOLEAN DEFAULT FALSE
            )
        ''')
        
        conn.commit()
        cur.close()
        conn.close()
        print("✅ Database initialized successfully!")
        return True
    except Exception as e:
        print(f"❌ Database connection failed: {e}")
        print("⚠️ Make sure PostgreSQL is running and credentials are correct")
        return False

# Health check
@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok', 'message': 'Vertex Bit API is running!'})

# Submit contact form
@app.route('/api/contact', methods=['POST'])
def submit_contact():
    try:
        data = request.get_json()
        print(f"📝 Received: {data}")
        
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
        
        print(f"✅ Saved: {name} - {email}")
        
        return jsonify({
            'success': True,
            'message': 'Thank you! We will contact you soon.'
        }), 200
        
    except Exception as e:
        print(f"❌ Error: {e}")
        return jsonify({'error': str(e)}), 500

# Get all contacts (ADMIN ONLY - you'll add auth later)
@app.route('/api/contacts', methods=['GET'])
def get_all_contacts():
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

# Mark contact as read
@app.route('/api/contacts/<int:contact_id>/read', methods=['PUT'])
def mark_as_read(contact_id):
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('UPDATE contacts SET is_read = TRUE WHERE id = %s', (contact_id,))
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({'success': True}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    print("🚀 Vertex Bit Backend Starting...")
    print("📍 API URL: http://localhost:5000")
    
    if init_db():
        app.run(debug=True, port=5000)
    else:
        print("⚠️ Please fix database connection and restart")