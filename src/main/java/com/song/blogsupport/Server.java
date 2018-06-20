package com.song.blogsupport;

import com.alibaba.fastjson.JSON;
import com.song.blogsupport.baiduindex.BaiduIndexService;
import com.song.blogsupport.baiduindex.BaiduIndexVo;
import com.song.blogsupport.comment.CommentService;
import com.song.blogsupport.comment.CommentVo;
import com.song.blogsupport.gossip.GossipService;
import com.song.blogsupport.gossip.GossipVo;
import com.song.blogsupport.server.MyExceptionHandler;
import com.song.blogsupport.server.Resp;
import com.song.blogsupport.utils.HTTPUtil;
import com.song.blogsupport.utils.NginxUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

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
        BaiduIndexService baiduIndexService = context.getBean(BaiduIndexService.class);
        /*before((request, response) -> {
            request.queryMap();
           log.info(request.queryParams()+request.body());
        });
        after((request, response) -> {
            log.info(response.body());
        });*/
        //comment
        exception(Exception.class, context.getBean(MyExceptionHandler.class));

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
        get("/index/verifyCode", (request, response) -> {
//<meta name="baidu-site-verification" content="E0Px6BvZ1U" />
            //先从数据库中查询是否存在，这种还是很容易被别人破解啊，每次都更新？
            //等等，这里假设，我知道别人的这个内容，然后也知道别人的域名，那是不是能添加到自己这里，哦，已经校验的，估计不能在添加了
            //查询是否有此域名并且已经注册了
            String domainName = request.queryParams("domainName");
            HTTPUtil.checkDomain(domainName);
            BaiduIndexVo baiduIndexVo = baiduIndexService.getByDomain(domainName);
            String verifyCode = null;
            if (baiduIndexVo == null) {
                verifyCode = RandomStringUtils.random(12);
                BaiduIndexVo insertVo = new BaiduIndexVo();
                insertVo.setDomainName(domainName);
                insertVo.setCreateTime(new Date());
                insertVo.setVerifyCode(verifyCode);
                baiduIndexService.insert(insertVo);
            } else {
                boolean isVerified = baiduIndexVo.getVerifyStatus();
                if (isVerified) {
                    throw new Exception("此域名:" + domainName + "已验证");
                } else {
                    verifyCode = baiduIndexVo.getVerifyCode();
                }
            }
            return new Resp<>(verifyCode).toString();
        });

        //校验域名
        get("/index/verify", (request, response) -> {
            String domainName = request.queryParams("domainName");
            String verifyCode = request.queryParams("verifyCode");
            //校验域名要做的就是访问首页，看meta里面是否有相应的数据
            /**
             * 妈个逼b这么难搞？我怎么知道是http还是https？
             */
            //我曹，真TM快疯了
            String url = "http://" + domainName;
            String resp = HTTPUtil.get(url);
            if (StringUtils.isNotEmpty(resp) && resp.contains(domainName) && resp.contains(verifyCode)) {
                return new Resp<>().toString();
            } else {
                return new Resp(1, "域名所有权校验失败", null);
            }
        });

        get("/index/add", (request, response) -> {
            String gitPagesUrl = request.queryParams("gitPagesUrl");
            //校验此url是否能访问到
            boolean isValidUrl = HTTPUtil.checkGithubPagesUrl(gitPagesUrl);
            if (!isValidUrl) {
                throw new Exception("非法的github pages url");
            }
            //校验域名
            String domainName = request.queryParams("domainName");
            boolean isValidDomain = HTTPUtil.checkDomain(domainName);
            if (!isValidDomain) {
                throw new Exception("非法的域名");
            }

            String email = request.queryParams("email");
            //生成一个nginx.conf文件
            NginxUtil.genConf(domainName, gitPagesUrl);
            //nginx reload service nginx reload
            NginxUtil.reload();
            response.header("Access-Control-Allow-Origin", "*");
            return new Resp<>().toString();
        });
    }
}
