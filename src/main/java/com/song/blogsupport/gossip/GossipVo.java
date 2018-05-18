package com.song.blogsupport.gossip;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

/**
 * Created by 001844 on 2018/5/9.
 */
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class GossipVo {
    //语录，个人语录，状态，说说
    private String type;
    private String content;
    private Date time;
    private String link;
}
