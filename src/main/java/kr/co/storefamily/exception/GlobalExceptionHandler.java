package kr.co.storefamily.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler({ AuthenticationException.class, DuplicateUserIdException.class, RegistrationException.class })
	public String handleBusinessException(RuntimeException ex, Model model) {
		model.addAttribute("errorMessage", ex.getMessage());
		return "error/general_error";
	}

	@ExceptionHandler(Exception.class)
	public String handleUnexpectedException(Exception ex, Model model) {
		model.addAttribute("errorMessage", "Unexpected error occurred. Please try again.");
		return "error/general_error";
	}
}
