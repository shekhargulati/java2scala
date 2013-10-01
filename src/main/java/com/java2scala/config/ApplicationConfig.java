package com.java2scala.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.java2scala.api.JavaToScalaController;

@Configuration
@EnableWebMvc
@ComponentScan(basePackageClasses = JavaToScalaController.class)
public class ApplicationConfig {

}
