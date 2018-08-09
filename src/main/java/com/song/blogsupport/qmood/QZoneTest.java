package com.song.blogsupport.qmood;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.song.blogsupport.utils.HTTPUtil;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;

/**
 * Created by 001844 on 2018/5/5.
 */
public class QZoneTest {
    public static int pos = 0;
    public static int total = 425;

    public static void main(String[] args) throws IOException {
        File file = new File("qzone.txt");
        String url = "https://user.qzone.qq.com/proxy/domain/taotao.qq.com/cgi-bin/emotion_cgi_msglist_v6?uin=504252262&ftype=0&sort=0&replynum=100&callback=_preloadCallback&code_version=1&format=jsonp&need_private_comment=1&" +
                "qzonetoken=815f60de009e8a66c49c3099aaee75523ae4c2f32e39f6578a56b09d286b119b57f1a5c4f88ba0e6&g_tk=852835650&num=40";

        while (total > 0) {
            String posStr = "&pos=" + pos;
            String url2 = url + posStr;
            //要设置cookie
            String str = HTTPUtil.get(url2);
            proc(str, file);

        }
    }

    public static void proc(String str, File file) throws IOException {
        int si = str.indexOf("(");
        int ei = str.lastIndexOf(")");
        String jsonStr = str.substring(si + 1, ei);
        JSONObject jo = JSON.parseObject(jsonStr);
        JSONArray jar = (JSONArray) jo.get("msglist");
        pos += jar.size();
        total = total - jar.size();

        for (int i = 0; i < jar.size(); i++) {
            JSONObject jsonObject = (JSONObject) jar.get(i);
            String content = (String) jsonObject.get("content");
            String createTime = (String) jsonObject.get("createTime");
            String result = "#### " + createTime + "\r\n" + content + "\r\n";

            FileUtils.write(file, result, "UTF-8", true);
        }
    }
}
