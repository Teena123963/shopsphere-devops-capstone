

import os
from flask import Flask, jsonify, request
import psycopg

app = Flask(__name__)

DATABASE_URL = os.environ.get("DATABASE_URL")


def get_db_connection():
    if DATABASE_URL:
        return psycopg.connect(DATABASE_URL)

    return psycopg.connect(
        host=os.environ["DB_HOST"],
        dbname=os.environ["DB_NAME"],
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        port=int(os.environ.get("DB_PORT", "5432")),
        sslmode="require"
    )


@app.get("/health")
def health():
    return jsonify(status="ok"), 200


@app.get("/products")
def products():
    return jsonify([
        {"id": 1, "name": "Laptop", "price": 55000},
        {"id": 2, "name": "Headphones", "price": 2500}
    ])


@app.post("/orders")
def create_order():
    data = request.get_json(silent=True) or {}

    product_id = data.get("product_id")
    quantity = data.get("quantity")

    if (type(product_id) is not int or
            type(quantity) is not int):
        return jsonify(
            error="product_id and quantity must be integers"
        ), 400

    if product_id < 1 or quantity < 1:
        return jsonify(error="Values must be positive"), 400

    with get_db_connection() as conn:
        with conn.cursor() as cur:
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS orders (
                    id BIGSERIAL PRIMARY KEY,
                    product_id INTEGER NOT NULL,
                    quantity INTEGER NOT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
                """
            )

            cur.execute(
                """
                INSERT INTO orders (product_id, quantity)
                VALUES (%s, %s)
                RETURNING id
                """,
                (product_id, quantity)
            )

            order_id = cur.fetchone()[0]

    return jsonify(
        message="Order created successfully",
        order_id=order_id
    ), 201
