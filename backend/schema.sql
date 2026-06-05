CREATE TABLE IF NOT EXISTS contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL,
    phone VARCHAR(40) NOT NULL,
    subject VARCHAR(200) NOT NULL DEFAULT 'General Inquiry',
    message TEXT NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_contacts_created_at ON contacts (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_contacts_is_read ON contacts (is_read);
CREATE INDEX IF NOT EXISTS idx_contacts_email ON contacts (email);
