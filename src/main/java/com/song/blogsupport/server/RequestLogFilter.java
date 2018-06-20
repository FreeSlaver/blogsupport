package com.song.blogsupport.server;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import spark.Request;
import spark.Response;

/**
 * Created by 001844 on 2018/6/20.
 */
@Service
@Slf4j
public class RequestLogFilter  implements spark.Filter {
    @Override
    public void handle(Request request, Response response) throws Exception {
        StringBuilder sb = new StringBuilder();
        sb.append("Log REQUEST=>").append("method: ").append(request.requestMethod());
        sb.append("url: " + request.url());
        sb.append("body: " + request.body());
        log.info(sb.toString());
    }
}
