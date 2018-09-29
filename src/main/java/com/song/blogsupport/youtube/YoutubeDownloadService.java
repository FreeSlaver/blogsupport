package com.song.blogsupport.youtube;

import com.song.blogsupport.utils.CommandUtil;
import org.springframework.stereotype.Service;

/**
 * Created by songxin on 2018/9/29.
 */
@Service
public class YoutubeDownloadService {


    public void download(String url) {
        //保存到那个目录？能让nginx看到吗？直接保存到apach目录下
        String com = "/usr/local/bin/youtube-dl -o '/var/www/html/%(title)s.%(ext)s' -f best/mp4 " + url;
        boolean result = CommandUtil.execute(com);
        //如何让结果写回？java返回结果让浏览器自动跳转


    }
}
