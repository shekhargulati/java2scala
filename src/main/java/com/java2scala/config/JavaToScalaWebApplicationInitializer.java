package com.java2scala.config;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class JavaToScalaWebApplicationInitializer implements WebApplicationInitializer {

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext applicationContext = new AnnotationConfigWebApplicationContext();
        applicationContext.register(ApplicationConfig.class);

        Dynamic dynamic = servletContext.addServlet("javaToScala", new DispatcherServlet(applicationContext));
        dynamic.addMapping("/api/*");
        dynamic.setLoadOnStartup(1);

    }

}
