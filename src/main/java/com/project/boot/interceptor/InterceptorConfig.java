package com.project.boot.interceptor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer{
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		List<String> urlList = new ArrayList<>();
		urlList.add("/admin/*");
		urlList.add("/admin/*/*");
		
		registry.addInterceptor(new AdminInterceptor())
		.addPathPatterns(urlList);
	}
}
