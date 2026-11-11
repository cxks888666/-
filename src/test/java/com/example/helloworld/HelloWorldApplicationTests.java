package com.example.helloworld;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class HelloWorldApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void helloWithoutAuthShouldBeUnauthorized() throws Exception {
        mockMvc.perform(get("/hello"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @WithMockUser(username = "test", roles = "USER")
    void helloWithAuthShouldReturnHelloWorld() throws Exception {
        mockMvc.perform(get("/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string("Hello World"));
    }

    @Test
    void loginWithCorrectCredentialsShouldSucceed() throws Exception {
        String body = "{\"username\":\"test\",\"password\":\"123456\"}";
        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isOk())
                .andExpect(content().json("{\"message\":\"Login successful\",\"username\":\"test\"}"));
    }

    @Test
    void loginWithWrongCredentialsShouldBeUnauthorized() throws Exception {
        String body = "{\"username\":\"test\",\"password\":\"wrong\"}";
        mockMvc.perform(post("/login")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(body))
                .andExpect(status().isUnauthorized());
    }
}
