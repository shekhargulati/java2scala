package com.java2scala.api;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.BAD_REQUEST)
public class JavaToScalaConversionException extends RuntimeException {

    public JavaToScalaConversionException(Exception e) {
        super("Failed to covert Java code to Scala", e);
    }

}
