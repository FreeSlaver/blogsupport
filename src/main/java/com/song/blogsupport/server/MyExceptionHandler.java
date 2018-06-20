package com.song.blogsupport.server;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.springframework.stereotype.Service;
import spark.ExceptionHandler;
import spark.Request;
import spark.Response;

/**
 * Created by 001844 on 2018/6/20.
 */
@Service
@Slf4j
public class MyExceptionHandler implements ExceptionHandler {
    @Override
    public void handle(Exception exception, Request request, Response response) {
        Resp<String> resp = new Resp(1, exception.getMessage(), ExceptionUtils.getRootCause(exception));
        response.body(resp.toString());
    }
}
