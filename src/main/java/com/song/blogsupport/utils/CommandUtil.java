package com.song.blogsupport.utils;

import lombok.extern.slf4j.Slf4j;

import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * Created by 001844 on 2018/6/13.
 */
@Slf4j
public class CommandUtil {

    public static boolean execute(String cmd) {
        try {
            Process p = Runtime.getRuntime().exec(cmd);
            BufferedReader br = new BufferedReader(
                    new InputStreamReader(p.getInputStream(), "UTF8"));
            String s = null;
            while ((s = br.readLine()) != null) {
                log.info("line: {}", s);
                System.out.println(s);
            }

            int wait = p.waitFor();
            int exit = p.exitValue();
            log.info("wait: {},exit: {}", wait, exit);
            p.destroy();
            if (wait == 0) {
                return true;
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    public static void main(String[] args) {
//      execute("cmd");
        //先要在本地测试，然后再centos上测试
//        execute("service nginx start");
        System.out.println("fuck");

//        boolean result = execute("/bin/bash -c youtube-dl --proxy socks5://localhost:1080/ -F s34fl3eFYMc");
//        boolean result = execute("/usr/local/bin/youtube-dl --proxy socks5://localhost:1080/ -F s34fl3eFYMc");
//        String com = "youtube-dl --proxy socks5://localhost:1080/ -F s34fl3eFYMc";
//        result = execute(com);
//        Process p = Runtime.getRuntime().exec("/bin/bash -c **YouTerminalSoftWareName**");
        String com = "/usr/local/bin/youtube-dl --proxy socks5://localhost:1080/  -o '/var/www/html/%(title)s.%(ext)s' -f best/mp4 s34fl3eFYMc";
//        CommandUtil.execute(com);
        Boolean result = execute(com);
        System.out.println(result);
    }
}
