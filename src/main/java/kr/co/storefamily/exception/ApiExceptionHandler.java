package kr.co.storefamily.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import kr.co.storefamily.dto.ApiErrorResponseDto;

@RestControllerAdvice(annotations = RestController.class)
public class ApiExceptionHandler {

	@ExceptionHandler(AuthenticationException.class)
	public ResponseEntity<ApiErrorResponseDto> handleAuthentication(AuthenticationException ex) {
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ApiErrorResponseDto(ex.getMessage()));
	}

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<ApiErrorResponseDto> handleValidation(MethodArgumentNotValidException ex) {
		String message = ex.getBindingResult().getFieldErrors().isEmpty()
				? "Invalid request."
				: ex.getBindingResult().getFieldErrors().get(0).getDefaultMessage();
		return ResponseEntity.badRequest().body(new ApiErrorResponseDto(message));
	}

	@ExceptionHandler(HttpMessageNotReadableException.class)
	public ResponseEntity<ApiErrorResponseDto> handleInvalidJson(HttpMessageNotReadableException ex) {
		return ResponseEntity.badRequest().body(new ApiErrorResponseDto("Invalid JSON request."));
	}

	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<ApiErrorResponseDto> handleIllegalArgument(IllegalArgumentException ex) {
		return ResponseEntity.badRequest().body(new ApiErrorResponseDto(ex.getMessage()));
	}
}
