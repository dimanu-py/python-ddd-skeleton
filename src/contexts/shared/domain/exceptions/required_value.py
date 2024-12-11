class RequiredValueError(Exception):
    def __init__(self) -> None:
        message = "Value is required, can't be None"
        super().__init__(message)
