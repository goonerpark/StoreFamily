package kr.co.storefamily.exception;

public class DuplicateUserIdException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public DuplicateUserIdException(String message) {
		super(message);
	}
}
