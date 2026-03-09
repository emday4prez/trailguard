CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    timezone VARCHAR(50) DEFAULT 'UTC',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., 'national_park', 'trail'
    region VARCHAR(100)
);

CREATE TABLE permit_rules (
    id SERIAL PRIMARY KEY,
    location_id INT REFERENCES locations(id) ON DELETE CASCADE,
    rule_type VARCHAR(50) NOT NULL, -- e.g., 'rolling_6_months', 'fixed_lottery'
    offset_days INT,                -- e.g., 180 (for 6 months out)
    fixed_date TIMESTAMP WITH TIME ZONE
);

CREATE TABLE watchers (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    location_id INT REFERENCES locations(id) ON DELETE CASCADE,
    target_trip_date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);