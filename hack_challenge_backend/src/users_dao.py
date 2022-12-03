"""
DAO (Data Access Object) file

Helper file containing functions for accessing data in our database
"""

from db import db
from db import User


def get_user_by_email(email):
    """
    Returns a user object from the database given an email
    """
    return User.query.filter(User.email == email).first()


def get_user_by_session_token(session_token):
    """
    Returns a user object from the database given a session token
    """
    return User.query.filter(User.session_token == session_token).first()

def verify_credentials(email, password):
    """
    Returns true if the credentials match, otherwise returns false
    """
    optional_user = get_user_by_email(email)
    if optional_user is None:
        return False, None
    return optional_user.verify_password(password), optional_user


def create_user(email, password):
    """
    Creates a User object in the database

    Returns if creation was successful, and the User object
    """
    optional_user = get_user_by_email(email)
    if optional_user is not None:
        return False, optional_user
    user = User(email=email, password=password)
    db.session.add(user)
    db.session.commit()
    return True, user
