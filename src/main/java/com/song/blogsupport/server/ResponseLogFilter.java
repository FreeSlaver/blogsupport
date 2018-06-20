package com.song.blogsupport.server;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import spark.Filter;
import spark.Request;
import spark.Response;

/**
 * Created by 001844 on 2018/6/20.
 */
@Service
@Slf4j
public class ResponseLogFilter implements Filter {
    @Override
    public void handle(Request request, Response response) throws Exception {
        StringBuilder sb = new StringBuilder();
        sb.append("Log RESPONSE:").append("status: ").append(response.status());
        sb.append("body: ").append(response.body());
        log.info(sb.toString());
    }
}
