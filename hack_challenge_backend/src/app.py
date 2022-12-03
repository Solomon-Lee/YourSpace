import json
from db import db
from flask import Flask
from db import User
from db import Booking
from flask import request
import users_dao
import datetime

app = Flask(__name__)
db_filename = "myspace.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code

def failure_response(message, code=404):
    return json.dumps({"error": message}), code

def extract_token(request):
    """
    Helper function that extracts the token from the header of a request
    """
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return False, json.dumps({"error": "Missing authorization header."})
    bearer_token = auth_header.replace("Bearer ", "").strip()
    if bearer_token is None or not bearer_token:
        return False, failure_response("Invalid authorization header", 400)
    return True, bearer_token

# your routes here
@app.route("/")
@app.route("/api/users/create/", methods=["POST"])
def create_user():
    """
    Endpoint for creating a user
    """
    body = json.loads(request.data)
    email = body.get("email")
    password = body.get("password")
    if email is None or password is None:
        return failure_response("Missing email or password", 400)
    success, user = users_dao.create_user(email, password)
    if not success:
        return failure_response("User already exists", 400)
    return success_response(
        {
            "session_token": user.session_token,
            "session_expiration": str(user.session_expiration)
        }
    )

@app.route("/api/users/get/")
def get_user():
    """
    Endpoint for getting a user by id
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    return success_response(user.serialize())

@app.route("/api/users/bookings/")
def get_user_bookings():
    """
    Endpoint for getting a user's bookings by id
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    return success_response(user.simple_serialize_booking(), 201)

@app.route("/api/bookings/", methods=["POST"])
def create_booking():
    """
    Endpoint for creating a booking
    """
    body = json.loads(request.data)
    name = body.get("name")
    location = body.get("location")
    capacity = body.get("capacity")
    timeslot = body.get("timeslot")
    category = body.get("category")
    if name is None or location is None or capacity is None or timeslot is None or category is None: 
        return failure_response("Missing input data.", 400)
    new_booking = Booking(name=name, location=location, capacity=capacity, timeslot=timeslot, category=category, status=False)
    db.session.add(new_booking)
    db.session.commit()
    return success_response(new_booking.serialize(), 201)

@app.route("/api/bookings/")
def get_bookings():
    """
    Endpoint for getting all bookings
    """
    bookings = [booking.serialize() for booking in Booking.query.all()]
    return success_response({"bookings":bookings})

@app.route("/api/bookings/<int:booking_id>/")
def get_booking(booking_id):
    """
    Endpoint for getting a booking by id
    """
    booking = Booking.query.filter_by(id=booking_id).first()
    if booking is None: 
        return failure_response("Booking not found!")
    return success_response(booking.serialize())

@app.route("/api/bookings/<int:booking_id>/add/", methods=["POST"])
def add_user_to_booking(booking_id):
    """
    Endpoint for adding a user to a booking by id
    """
    booking = Booking.query.filter_by(id=booking_id).first()
    if booking is None:
        return failure_response("Booking not found!")
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    booking.status = True 
    booking.users.append(user)
    user.bookings.append(booking)
    db.session.commit()
    return success_response(booking.serialize())

@app.route("/api/bookings/<int:booking_id>/delete/", methods=["DELETE"])
def delete_user_from_booking(booking_id):
    """
    Endpoint for deleting a user from a booking by id
    """
    booking = Booking.query.filter_by(id=booking_id).first()
    if booking is None:
        return failure_response("Booking not found!")
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    try:
        user.bookings.remove(booking)
    except:
        return failure_response("Delete unsuccessful!")
    else:
        booking.status = False
    db.session.commit()
    return success_response(booking.serialize())

@app.route("/login/", methods=["POST"])
def login():
    """
    Endpoint for logging in a user
    """
    body = json.loads(request.data)
    email = body.get("email")
    password = body.get("password")
    if email is None or password is None:
        return failure_response("Missing email or password", 400)
    success, user = users_dao.verify_credentials(email, password)
    if not success:
        return failure_response("Incorrect email or password", 401)
    user.renew_session()
    db.session.commit()
    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration)
    })

@app.route("/logout/", methods=["POST"])
def logout():
    """
    Endpoint for logging out a user
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    user.session_token = ""
    user.session_expiration = datetime.datetime.now()
    db.session.commit()
    return success_response({"message": "You have successfully logged out"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
