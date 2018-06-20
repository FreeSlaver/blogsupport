package com.song.blogsupport.utils;

import com.github.odiszapc.nginxparser.*;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

/**
 * Created by 001844 on 2018/6/13.
 */
@Slf4j
public class NginxUtil {

    public static void read() {
        NgxConfig conf = null;
        try {
            conf = NgxConfig.read("/etc/nginx/nginx.conf");
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
        NgxParam workers = conf.findParam("worker_processes");       // Ex.1
        workers.getValue(); // "1"
        NgxParam listen = conf.findParam("http", "server", "listen"); // Ex.2
        listen.getValue(); // "8889"
        List<NgxEntry> rtmpServers = conf.findAll(NgxConfig.BLOCK, "rtmp", "server"); // Ex.3
        for (NgxEntry entry : rtmpServers) {
            ((NgxBlock) entry).getName(); // "server"
            ((NgxBlock) entry).findParam("application", "live"); // "on" for the first iter, "off" for the second one
        }
    }

    public static void genConf(String domainName, String gitPagesUrl) throws Exception {
        String path = "/etc/nginx/conf.d/" + domainName + ".conf";
        File confFile = new File(path);
        if (confFile.exists()) {
            throw new Exception("域名：" + domainName + "对应的文件已存在");
        }
        boolean createSuccess = confFile.createNewFile();
        if (!createSuccess) {
            throw new Exception("创建域名：" + domainName + "对应的conf文件出错");
        }
        //创建对应的日志文件?
        File logDir = new File("/var/log/nginx/" + domainName);
        boolean sucess = logDir.mkdirs();
        if (!sucess) {
            throw new Exception("创建域名：" + domainName + "对应的日志目录出错");
        }
        NgxConfig conf = new NgxConfig();
        NgxBlock serverBlock = new NgxBlock();
        serverBlock.addValue("server");

        NgxParam listenParam = new NgxParam();
        listenParam.addValue("listen 80");
        serverBlock.addEntry(listenParam);

        NgxParam serverNameParam = new NgxParam();
        serverNameParam.addValue("server_name " + domainName);
        serverBlock.addEntry(serverNameParam);

        NgxBlock locationBlock = new NgxBlock();
        locationBlock.addValue("location /");

        NgxParam proxyPass = new NgxParam();
        proxyPass.addValue("proxy_pass " + gitPagesUrl);
        locationBlock.addEntry(proxyPass);

        NgxParam proxyRedirect = new NgxParam();
        proxyRedirect.addValue("proxy_redirect off");
        locationBlock.addEntry(proxyRedirect);

        NgxParam proxyHeader1 = new NgxParam();
        String str3 = "proxy_set_header User-Agent \"Mozilla/5.0\"";
        proxyHeader1.addValue(str3);
        locationBlock.addEntry(proxyHeader1);

        NgxParam proxyHeader2 = new NgxParam();
        proxyHeader2.addValue("proxy_set_header Host $host");
        locationBlock.addEntry(proxyHeader2);

        NgxParam proxyHeader3 = new NgxParam();
        proxyHeader3.addValue("proxy_set_header X-Real-IP $remote_addr");
        locationBlock.addEntry(proxyHeader3);

        NgxParam proxyHeader4 = new NgxParam();
        proxyHeader4.addValue("proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for");
        locationBlock.addEntry(proxyHeader4);

        NgxParam accessLog = new NgxParam();
        accessLog.addValue("access_log /var/log/nginx/" + domainName + "/access.log main");
        locationBlock.addEntry(accessLog);

        NgxParam errorLog = new NgxParam();
        errorLog.addValue("error_log /var/log/nginx/" + domainName + "/error.log warn");
        locationBlock.addEntry(errorLog);

        serverBlock.addEntry(locationBlock);

        conf.addEntry(serverBlock);
        //write sth
        NgxDumper dumper = new NgxDumper(conf);
        try {
            dumper.dump(new FileOutputStream(new File(path)));
        } catch (FileNotFoundException e) {
            log.error(e.getMessage(), e);
        }
    }

    public static void main(String[] args) throws Exception {
//        read();
//        dump();
        genConf("fate.com", "https://fuckthejob.github.io");
    }

    public static void reload() {
        CommandUtil.execute("service nginx reload");
    }
    public static void restart(){
        CommandUtil.execute("service nginx restart");
    }

}
