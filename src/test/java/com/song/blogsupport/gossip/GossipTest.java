package com.song.blogsupport.gossip;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * Created by 001844 on 2018/5/11.
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class GossipTest {
    @Autowired
    private GossipService gossipService;

    @Test
    public void test() {
//        String link = "https://www.dropbox.com/s/bu572g2n019j19n/tree.JPG?dl=0";
//        String link = "https://www.dropbox.com/s/us3dcb2dek798rn/voicetest.mp3?dl=0";
        String link = "https://www.dropbox.com/s/pw801k7a9reh5kr/%E8%A7%86%E9%A2%91%202018-5-11%2022%2000%2015.mp4?dl=0";

        GossipVo gossipVo = new GossipVo();
        gossipVo.setContent("只是虾米截图的树");
        gossipVo.setLink(link);
        gossipVo.setType("mood");
        gossipVo.setTime(new Date());

        gossipService.add(gossipVo);
    }

}


