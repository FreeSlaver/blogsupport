package com.song.blogsupport;

import com.alibaba.fastjson.JSON;
import com.song.blogsupport.comment.CommentService;
import com.song.blogsupport.comment.CommentVo;
import com.song.blogsupport.gossip.GossipService;
import com.song.blogsupport.gossip.GossipVo;
import com.song.blogsupport.server.Resp;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import spark.ExceptionHandler;
import spark.Request;
import spark.Response;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Set;

import static spark.Spark.*;

/**
 * Created by 001844 on 2018/4/18.
 */
@Slf4j
public class Server {

    private static final String path = "classpath:/applicationContext.xml";

    public static void main(String[] args) throws InterruptedException {
        ApplicationContext context = new ClassPathXmlApplicationContext(path);
        CommentService commentService = context.getBean(CommentService.class);
        GossipService gossipService = context.getBean(GossipService.class);
        /*before((request, response) -> {
            request.queryMap();
           log.info(request.queryParams()+request.body());
        });
        after((request, response) -> {
            log.info(response.body());
        });*/
        //comment
        exception(Exception.class, new ExceptionHandler() {
            @Override
            public void handle(Exception exception, Request request, Response response) {
                Resp<String> resp = new Resp(ExceptionUtils.getThrowables(exception));
                response.body(resp.toString());
            }
        });

        //view times
        get("/view/get", (request, response) -> {
            Set<String> params = request.queryParams();
            System.out.println(params.toArray());
            String body = request.body();
            System.out.println(body);
            return 100;
        });
        post("/comment/add", (request, response) -> {
            String body = request.body();
            System.out.println(body);
            CommentVo commentVo = JSON.parseObject(body, CommentVo.class);
            commentService.add(commentVo);

            response.header("Access-Control-Allow-Origin", "*");
            return new Resp<>().toString();
        });

        get("/comment/list", (request, response) -> {
            String blogTitle = request.queryParams("blogTitle");
            System.out.println("blogTitle" + blogTitle);
            List<CommentVo> comments = commentService.list(blogTitle);
            System.out.println(Arrays.toString(comments.toArray()));

            Resp<List<CommentVo>> resp = new Resp<List<CommentVo>>(comments);
            response.header("Access-Control-Allow-Origin", "*");
            return JSON.toJSONString(resp);
        });

        get("/gossip/add", (request, response) -> {
            String gossip = request.queryParams("gossip");
            if (gossip == null || !gossip.equals("Z29kZ29zc2lw")) {
                throw new IllegalArgumentException("gossip wrong,need god's power");
            }
            String type = request.queryParams("type");
            String content = request.queryParams("content");
            String link = request.queryParams("link");
            String timeStr = request.queryParams("time");
            if (StringUtils.isEmpty(content) && StringUtils.isEmpty(link)) {
                throw new IllegalArgumentException("content and link are null");
            }
            if (StringUtils.isEmpty(type)) {
                throw new IllegalArgumentException("type null");
            }
            Date time = null;
            if (StringUtils.isNotEmpty(timeStr)) {
                time = DateUtils.parseDate(timeStr, "yyyy-MM-dd HH:mm");
            } else {
                time = new Date();
            }
            gossipService.add(new GossipVo(type, content, time, link));

            return new Resp<>().toString();
        });

    }
}
