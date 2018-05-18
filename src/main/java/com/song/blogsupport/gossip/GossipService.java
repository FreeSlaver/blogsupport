package com.song.blogsupport.gossip;

import com.song.blogsupport.utils.GitUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by 001844 on 2018/5/10.
 */
@Service
@Slf4j
public class GossipService {
    private static final String DIR = "/data/songxin1990.github.io/_posts/me/";
    private static final String GIT_REPO = "/data/songxin1990.github.io/";
    //    private static final String DIR = "F:\\songxin1990.github.io\\_posts\\me\\";
//    private static final String GIT_REPO = "F:\\songxin1990.github.io\\";
    private static final String DEFAULT_TIME_PATTERN = "yyyy-MM-dd";
    private static final String TIME_PATTERN = "yyyy-MM-dd HH:mm";

    public void add(GossipVo gossipVo) {
        File file = getFile(gossipVo.getType());
        if (file == null || !file.exists() || file.length() == 0L) {
            throw new IllegalArgumentException("file not found or empty");
        }
        String link = gossipVo.getLink();
        String content = gossipVo.getContent();
        StringBuilder sb = new StringBuilder();
        String time = DateFormatUtils.format(gossipVo.getTime(), DEFAULT_TIME_PATTERN);
        sb.append("### ").append(time).append("\r\n");
        if (StringUtils.isNotEmpty(content)) {
            sb.append(content).append("\r\n");
        }
        if (StringUtils.isNotEmpty(link)) {
            String linkResult = process(link);
            sb.append(linkResult).append("\r\n");
        }
        try {
            List<String> lines = FileUtils.readLines(file, "UTF-8");
            if (lines != null && !lines.isEmpty()) {
                int i = lines.lastIndexOf("---");
                lines.add(++i, sb.toString());

                FileUtils.writeLines(file, lines);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
//        GitUtil.commitByPwd(GIT_REPO,gossipVo.getType());
        new Thread(new Runnable() {
            @Override
            public void run() {
                GitUtil.commitBySSHKey(GIT_REPO, gossipVo.getType());
            }
        }).start();

    }


    private String process(String link) {
        if (StringUtils.isEmpty(link)) {
            return null;
        }
        int i = link.lastIndexOf(".");
        int j = link.lastIndexOf("/");
        String fileName = link.substring(j + 1, i);
        String linkType = link.substring(i + 1);
        //判断url是图片，还是音频，还是视频
        StringBuilder sb = new StringBuilder();
        if (linkType.equalsIgnoreCase("jpg") || linkType.equalsIgnoreCase("png") || linkType.equalsIgnoreCase("gif")) {
            sb.append("<div class=\"thumbnail\" style=\"width:85%\">");
            sb.append("\r\n\t").append("<img src=\"").append(link).append("\" alt=\"").append(fileName).append("\" style=\"width:100%\">");
            sb.append("\r\n").append("</div>");
            return sb.toString();
        } else if (linkType.equalsIgnoreCase("mp3") || linkType.equalsIgnoreCase("aac")) {
            sb.append("<audio controls><source src='").append(link).append("' type='audio/mpeg' /></audio>");
        } else if (linkType.equalsIgnoreCase("mp4") || linkType.equalsIgnoreCase("")) {
            sb.append("<div class='embed-responsive embed-responsive-16by9' style='width:85%'>")
                    .append("\r\n\t").append("<iframe class='embed-responsive-item' src='").append(link)
                    .append("' allowfullscreen></iframe>")
                    .append("\r\n").append("</div>");
        } else {
            log.error("link file type invalid:{}", linkType);
        }
        return sb.toString();
    }

    private File getFile(String type) {
        File dir = new File(DIR);
        File[] files = dir.listFiles();
        if (files == null || files.length == 0) {
            return null;
        }
        for (File file : files) {
            String name = file.getName();
            if (StringUtils.containsIgnoreCase(name, type)) {
                return file;
            }
        }
        return null;
    }

    public static void main(String[] args) {
       /* String url = "http://imgage.3god.com/test.jpg";
        GossipService gossipService = new GossipService();
        GossipVo gossipVo = new GossipVo();
        gossipVo.setContent("Hello wolr");
        gossipVo.setLink(url);
        gossipService.add(gossipVo);*/

//        String link = "https://www.dropbox.com/s/pw801k7a9reh5kr/%E8%A7%86%E9%A2%91%202018-5-11%2022%2000%2015.mp4?dl=0";
        String link = "http://devmrn.cornerstoneadmin.org/wp-content/uploads/sites/4/2017/10/GF-Lost.jpg";
        GossipService gossipService = new GossipService();
        gossipService.process(link);
//        link = link.replace("dl=0", "raw=1");
//        System.out.println(link);
    }
}
