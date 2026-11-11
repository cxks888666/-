package com.example.helloworld.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {

    /**
     * 需要 Spring Security 认证后才能访问的 HelloWorld 接口。
     * 认证通过后返回 "Hello World"。
     */
    @GetMapping("/hello")
    public String hello() {
        return "Hello World";
    }
}
