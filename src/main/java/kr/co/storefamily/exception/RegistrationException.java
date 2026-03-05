package kr.co.storefamily.exception;

public class RegistrationException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public RegistrationException(String message) {
		super(message);
	}

	public RegistrationException(String message, Throwable cause) {
		super(message, cause);
	}
}
