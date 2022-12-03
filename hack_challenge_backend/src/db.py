import hashlib
from flask_sqlalchemy import SQLAlchemy
import bcrypt
import datetime
import os

db = SQLAlchemy()

association_table = db.Table(
    "association",
    db.Column("booking_id", db.Integer, db.ForeignKey("bookings.id")),
    db.Column("user_id", db.Integer, db.ForeignKey("users.id"))
)

# your classes here
class User(db.Model):
    """
    User model
    Has a one-to-many relationship with the Booking Model
    """
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    email = db.Column(db.String, nullable = False)
    password = db.Column(db.String, nullable = False)
    bookings = db.relationship("Booking", secondary=association_table, back_populates="users")
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)

    def __init__(self, **kwargs):
        """
        Initializes a User object 
        """
        self.email = kwargs.get("email", "")
        self.password = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.renew_session()

    def serialize(self):
        """
        Serializes a User object 
        """
        return{
            "id": self.id,
            "email": self.email,
            "bookings": [b.simple_serialize() for b in self.bookings]
        }
    
    def simple_serialize(self):
        """
        Simple serializes a User object 
        """
        return{
            "id": self.id,
            "email": self.email
        }

    def simple_serialize_booking(self):
        """
        Simple serializes a User object with bookings
        """
        return{
            "bookings": [b.simple_serialize() for b in self.bookings]
        }

    def _urlsafe_base_64(self):
        """
        Randomly generates hashed tokens (used for session/update tokens)
        """
        return hashlib.sha1(os.urandom(64)).hexdigest()

    def renew_session(self):
        """
        Renews the sessions, i.e.
        1. Creates a new session token
        2. Sets the expiration time of the session to be a day from now
        3. Creates a new update token
        """
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)

    def verify_password(self, password):
        """
        Verifies the password of a user
        """
        return bcrypt.checkpw(password.encode("utf8"), self.password)

    def verify_session_token(self, session_token):
        """
        Verifies the session token of a user
        """
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration
    
class Booking(db.Model):
    """
    Booking model
    """
    __tablename__ = "bookings"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    name = db.Column(db.String, nullable = False)
    location = db.Column(db.String, nullable = False)
    capacity = db.Column(db.String, nullable = False)
    timeslot = db.Column(db.String, nullable = False)
    category = db.Column(db.Integer, nullable = False)
    status = db.Column(db.Boolean, nullable = False)
    users = db.relationship("User", secondary=association_table, back_populates="bookings")

    def __init__(self, **kwargs):
        """
        Initializes a Booking object 
        """
        self.name = kwargs.get("name", "")
        self.location = kwargs.get("location", "")
        self.capacity = kwargs.get("capacity", "")
        self.timeslot = kwargs.get("timeslot", "")
        self.category = kwargs.get("category", "")
        self.status = kwargs.get("status", "")

    def serialize(self):
        """
        Serializes a Booking object 
        """
        return{
            "id": self.id,
            "name": self.name,
            "location": self.location,
            "capacity": self.capacity,
            "timeslot": self.timeslot,
            "category": self.category,
            "status": self.status,
            "users": [u.simple_serialize() for u in self.users]
        }

    def simple_serialize(self):
        """
        Simple serializes a Booking object 
        """
        return{
            "id": self.id,
            "name": self.name,
            "location": self.location,
            "capacity": self.capacity,
            "timeslot": self.timeslot,
            "category": self.category, 
            "status": self.status,
        }

