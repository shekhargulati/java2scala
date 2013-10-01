package com.java2scala.parser;

import japa.parser.JavaParser;
import japa.parser.ast.CompilationUnit;

import java.io.ByteArrayInputStream;

import com.mysema.scalagen.Converter;

public abstract class JavaToScalaParser {

    public static String toScalaCode(String javaCode) throws Exception {
        byte[] bytes = javaCode.getBytes("UTF-8");
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
        CompilationUnit compilationUnit = JavaParser.parse(byteArrayInputStream);
        String scalaCode = Converter.instance().toScala(compilationUnit);
        return scalaCode;
    }

}
