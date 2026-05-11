package kr.co.storefamily.security;

import java.nio.charset.StandardCharsets;
import java.util.Date;

import javax.crypto.SecretKey;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import kr.co.storefamily.model.Member;

@Component
public class JwtTokenProvider {

	private final SecretKey secretKey;
	private final long accessTokenValidityMs;

	public JwtTokenProvider(@Value("${jwt.secret}") String secret,
			@Value("${jwt.access-token-validity-ms}") long accessTokenValidityMs) {
		this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
		this.accessTokenValidityMs = accessTokenValidityMs;
	}

	public String createAccessToken(Member member) {
		Date now = new Date();
		Date expiresAt = new Date(now.getTime() + accessTokenValidityMs);
		return Jwts.builder()
				.setSubject(member.getId())
				.claim("memberBno", member.getBno())
				.claim("name", member.getName())
				.claim("role", normalizeRole(member.getPosition()))
				.setIssuedAt(now)
				.setExpiration(expiresAt)
				.signWith(secretKey)
				.compact();
	}

	public String getSubject(String token) {
		return parseClaims(token).getSubject();
	}

	public String getRole(String token) {
		Object role = parseClaims(token).get("role");
		return role == null ? "ROLE_EMPLOYEE" : role.toString();
	}

	public boolean validateToken(String token) {
		parseClaims(token);
		return true;
	}

	private Claims parseClaims(String token) {
		return Jwts.parserBuilder()
				.setSigningKey(secretKey)
				.build()
				.parseClaimsJws(token)
				.getBody();
	}

	private String normalizeRole(String position) {
		if ("사장".equals(position)) {
			return "ROLE_CEO";
		}
		if ("관리자".equals(position)) {
			return "ROLE_MANAGER";
		}
		return "ROLE_EMPLOYEE";
	}
}
