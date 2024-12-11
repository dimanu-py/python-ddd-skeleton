from typing import TypeVar

T = TypeVar("T")


class IncorrectValueTypeError(Exception):
    def __init__(self, value: T) -> None:
        message = f"Value '{value}' is not of type {type(value).__name__}"
        super().__init__(message)
