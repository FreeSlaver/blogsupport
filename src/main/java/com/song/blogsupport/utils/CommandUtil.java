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
            while ((s = br.readLine()) != null)
                log.info("line: {}", s);

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
        boolean result = execute("ping data.3gods.com");
        System.out.println(result);
    }
}
