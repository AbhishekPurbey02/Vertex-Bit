import atexit

from flask import Flask, jsonify
from flask_cors import CORS

from config import Config
from contacts import contacts_bp
from db import close_pool, init_db, init_pool


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    app.config["MAX_CONTENT_LENGTH"] = Config.MAX_CONTENT_LENGTH

    CORS(
        app,
        resources={r"/api/*": {"origins": Config.CORS_ORIGINS}},
        supports_credentials=True,
    )

    app.register_blueprint(contacts_bp)

    @app.cli.command("init-db")
    def init_db_command():
        startup()
        print("Database schema initialized.")

    @app.errorhandler(413)
    def payload_too_large(_error):
        return jsonify({"error": "Request payload is too large."}), 413

    @app.errorhandler(404)
    def not_found(_error):
        return jsonify({"error": "Route not found."}), 404

    @app.errorhandler(500)
    def internal_error(_error):
        return jsonify({"error": "Internal server error."}), 500

    return app


app = create_app()


def startup():
    init_pool()
    init_db()


atexit.register(close_pool)


if __name__ == "__main__":
    startup()
    app.run(host="0.0.0.0", port=5000, debug=Config.FLASK_DEBUG)
