import re

from flask import Blueprint, jsonify, request

from db import get_cursor

contacts_bp = Blueprint("contacts", __name__, url_prefix="/api")

EMAIL_PATTERN = re.compile(r"^[^\s@]+@[^\s@]+\.[^\s@]+$")


def _serialize_contact(contact):
    return {
        "id": contact["id"],
        "name": contact["name"],
        "email": contact["email"],
        "phone": contact["phone"],
        "subject": contact["subject"],
        "message": contact["message"],
        "is_read": contact["is_read"],
        "created_at": contact["created_at"].isoformat()
        if contact["created_at"]
        else None,
        "updated_at": contact["updated_at"].isoformat()
        if contact["updated_at"]
        else None,
    }


def _validate_contact_payload(data):
    errors = {}
    name = (data.get("name") or "").strip()
    email = (data.get("email") or "").strip()
    phone = (data.get("phone") or "").strip()
    subject = (data.get("subject") or "General Inquiry").strip()
    message = (data.get("message") or "").strip()

    if not name:
        errors["name"] = "Name is required."
    elif len(name) > 120:
        errors["name"] = "Name must be 120 characters or fewer."

    if not email:
        errors["email"] = "Email is required."
    elif not EMAIL_PATTERN.match(email):
        errors["email"] = "Enter a valid email address."
    elif len(email) > 160:
        errors["email"] = "Email must be 160 characters or fewer."

    if not phone:
        errors["phone"] = "Phone is required."
    elif len(phone) < 7 or len(phone) > 40:
        errors["phone"] = "Enter a valid phone number."

    if len(subject) > 200:
        errors["subject"] = "Subject must be 200 characters or fewer."

    if not message:
        errors["message"] = "Message is required."
    elif len(message) < 10:
        errors["message"] = "Message must include at least 10 characters."

    return errors, {
        "name": name,
        "email": email,
        "phone": phone,
        "subject": subject or "General Inquiry",
        "message": message,
    }


@contacts_bp.get("/health")
def health():
    return jsonify({"status": "ok", "message": "Vertex Bit API is running."})


@contacts_bp.post("/contact")
def submit_contact():
    data = request.get_json(silent=True) or {}
    errors, payload = _validate_contact_payload(data)

    if errors:
        return jsonify({"error": "Validation failed.", "fields": errors}), 400

    try:
        with get_cursor(commit=True) as cur:
            cur.execute(
                """
                INSERT INTO contacts (name, email, phone, subject, message)
                VALUES (%s, %s, %s, %s, %s)
                RETURNING *
                """,
                (
                    payload["name"],
                    payload["email"],
                    payload["phone"],
                    payload["subject"],
                    payload["message"],
                ),
            )
            contact = cur.fetchone()

        return (
            jsonify(
                {
                    "success": True,
                    "message": "Thank you. We will contact you soon.",
                    "contact": _serialize_contact(contact),
                }
            ),
            201,
        )
    except Exception as e:
        print("=" * 50)
        print("DATABASE ERROR:")
        print(e)
        print("=" * 50)
        return jsonify({"error": str(e)}), 500


@contacts_bp.get("/contacts")
def list_contacts():
    search = (request.args.get("search") or "").strip()
    read_filter = (request.args.get("is_read") or "").strip().lower()
    limit = min(max(request.args.get("limit", default=50, type=int), 1), 100)
    offset = max(request.args.get("offset", default=0, type=int), 0)

    where = []
    params = []

    if search:
        where.append(
            "(name ILIKE %s OR email ILIKE %s OR phone ILIKE %s OR subject ILIKE %s OR message ILIKE %s)"
        )
        search_param = f"%{search}%"
        params.extend([search_param] * 5)

    if read_filter in {"true", "false"}:
        where.append("is_read = %s")
        params.append(read_filter == "true")

    where_sql = f"WHERE {' AND '.join(where)}" if where else ""

    try:
        with get_cursor() as cur:
            cur.execute(
                f"""
                SELECT COUNT(*) AS total,
                    COUNT(*) FILTER (WHERE is_read = FALSE) AS unread,
                    COUNT(*) FILTER (WHERE is_read = TRUE) AS read
                FROM contacts
                {where_sql}
                """,
                params,
            )
            stats = cur.fetchone()

            cur.execute(
                f"""
                SELECT *
                FROM contacts
                {where_sql}
                ORDER BY created_at DESC
                LIMIT %s OFFSET %s
                """,
                [*params, limit, offset],
            )
            contacts = [_serialize_contact(row) for row in cur.fetchall()]

        return (
            jsonify(
                {
                    "contacts": contacts,
                    "stats": {
                        "total": stats["total"],
                        "read": stats["read"],
                        "unread": stats["unread"],
                    },
                    "limit": limit,
                    "offset": offset,
                }
            ),
            200,
        )
    except Exception:
        return jsonify({"error": "Unable to load contacts."}), 500


@contacts_bp.get("/contacts/<int:contact_id>")
def get_contact(contact_id):
    try:
        with get_cursor() as cur:
            cur.execute("SELECT * FROM contacts WHERE id = %s", (contact_id,))
            contact = cur.fetchone()

        if not contact:
            return jsonify({"error": "Contact not found."}), 404

        return jsonify({"contact": _serialize_contact(contact)}), 200
    except Exception:
        return jsonify({"error": "Unable to load contact."}), 500


@contacts_bp.put("/contacts/<int:contact_id>/read")
def update_read_status(contact_id):
    data = request.get_json(silent=True) or {}
    is_read = data.get("is_read", True)

    if not isinstance(is_read, bool):
        return jsonify({"error": "is_read must be true or false."}), 400

    try:
        with get_cursor(commit=True) as cur:
            cur.execute(
                """
                UPDATE contacts
                SET is_read = %s, updated_at = CURRENT_TIMESTAMP
                WHERE id = %s
                RETURNING *
                """,
                (is_read, contact_id),
            )
            contact = cur.fetchone()

        if not contact:
            return jsonify({"error": "Contact not found."}), 404

        return jsonify({"success": True, "contact": _serialize_contact(contact)}), 200
    except Exception:
        return jsonify({"error": "Unable to update contact."}), 500


@contacts_bp.delete("/contacts/<int:contact_id>")
def delete_contact(contact_id):
    try:
        with get_cursor(commit=True) as cur:
            cur.execute(
                "DELETE FROM contacts WHERE id = %s RETURNING id",
                (contact_id,),
            )
            deleted = cur.fetchone()

        if not deleted:
            return jsonify({"error": "Contact not found."}), 404

        return jsonify({"success": True, "deleted_id": contact_id}), 200
    except Exception:
        return jsonify({"error": "Unable to delete contact."}), 500
