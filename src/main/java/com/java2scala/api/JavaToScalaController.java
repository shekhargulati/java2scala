package com.java2scala.api;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.java2scala.parser.JavaToScalaParser;

@Controller
@RequestMapping("/javatoscala")
public class JavaToScalaController {

    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<String> convertJavaToScala(@RequestBody String code) {
        try {
            System.out.println(code);
            Map map = new Gson().fromJson(code, Map.class);
            String scala = JavaToScalaParser.toScalaCode((String) map.get("code"));
            Map<String, String> scalaCodeMap = new HashMap<String, String>();
            scalaCodeMap.put("scalaCode", scala);
            String json = new Gson().toJson(scalaCodeMap);
            return new ResponseEntity<String>(json, HttpStatus.OK);
        } catch (Exception e) {
            String error = ExceptionUtils.getStackTrace(e);
            Map<String, String> errorMap = new HashMap<String, String>();
            errorMap.put("error", error);
            return new ResponseEntity<String>(new Gson().toJson(errorMap), HttpStatus.OK);
        }
    }
}
