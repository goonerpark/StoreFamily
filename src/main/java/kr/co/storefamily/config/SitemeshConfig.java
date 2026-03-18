package kr.co.storefamily.config;

import java.util.Collections;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.opensymphony.module.sitemesh.filter.PageFilter;

@Configuration
public class SitemeshConfig {

	@Bean
	public FilterRegistrationBean<PageFilter> sitemeshFilter() {
		FilterRegistrationBean<PageFilter> registration = new FilterRegistrationBean<>();
		registration.setFilter(new PageFilter());
		registration.setUrlPatterns(Collections.singletonList("/*"));
		registration.setName("sitemesh");
		registration.setOrder(2);
		return registration;
	}
}
