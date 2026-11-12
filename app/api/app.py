


import os
from flask import Flask, jsonify, request

app = Flask(__name__)

DATABASE_URL = os.environ.get("DATABASE_URL")


def get_db_connection():
    # Load database driver only when database is needed
    import psycopg

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


@app.route("/health", methods=["GET"])
def health():
    return jsonify(status="ok"), 200


@app.route("/products", methods=["GET"])
def get_products():
    products = [
        {"id": 1, "name": "Laptop", "price": 55000},
        {"id": 2, "name": "Mobile", "price": 25000}
    ]

    return jsonify(products), 200


@app.route("/orders", methods=["POST"])
def create_order():
    data = request.get_json()

    if not data:
        return jsonify({"error": "Request body is required"}), 400

    product_id = data.get("product_id")
    quantity = data.get("quantity")

    if not isinstance(product_id, int) or not isinstance(quantity, int):
        return jsonify({"error": "product_id and quantity must be integers"}), 400

    if product_id <= 0 or quantity <= 0:
        return jsonify({"error": "Values must be greater than zero"}), 400

    try:
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    INSERT INTO orders (product_id, quantity)
                    VALUES (%s, %s)
                    RETURNING id
                    """,
                    (product_id, quantity)
                )

                order_id = cur.fetchone()[0]

        return jsonify({
            "message": "Order created successfully",
            "order_id": order_id
        }), 201

    except Exception as error:
        return jsonify({"error": str(error)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
