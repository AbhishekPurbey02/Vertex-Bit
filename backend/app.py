from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)  # This fixes CORS too!

# File to store contacts
CONTACTS_FILE = 'contacts.json'

# Load existing contacts
def load_contacts():
    if os.path.exists(CONTACTS_FILE):
        with open(CONTACTS_FILE, 'r') as f:
            return json.load(f)
    return []

# Save contacts
def save_contacts(contacts):
    with open(CONTACTS_FILE, 'w') as f:
        json.dump(contacts, f, indent=2)

# Health check endpoint
@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok', 'message': 'Vertex Bit API is running!'})

# Contact form endpoint
@app.route('/api/contact', methods=['POST'])
def contact():
    try:
        data = request.get_json()
        print(f"Received: {data}")  # This will show in terminal
        
        name = data.get('name')
        email = data.get('email')
        phone = data.get('phone')
        subject = data.get('subject', 'General Inquiry')
        message = data.get('message')
        
        # Validation
        if not name or not email or not phone or not message:
            return jsonify({'error': 'All fields are required'}), 400
        
        # Save to JSON file
        contacts = load_contacts()
        new_contact = {
            'id': len(contacts) + 1,
            'name': name,
            'email': email,
            'phone': phone,
            'subject': subject,
            'message': message,
            'created_at': datetime.now().isoformat()
        }
        contacts.append(new_contact)
        save_contacts(contacts)
        
        print(f"Saved contact #{new_contact['id']} - {name}")
        
        return jsonify({
            'success': True,
            'message': 'Thank you! We will contact you soon.'
        }), 200
        
    except Exception as e:
        print(f"Error: {e}")
        return jsonify({'error': str(e)}), 500

# Get all contacts (for admin)
@app.route('/api/contacts', methods=['GET'])
def get_contacts():
    contacts = load_contacts()
    return jsonify(contacts), 200

if __name__ == '__main__':
    print(" Vertex Bit Backend Starting...")
    print(" API URL: http://localhost:5000")
    print(" Contact endpoint: http://localhost:5000/api/contact")
    app.run(debug=True, port=5000)