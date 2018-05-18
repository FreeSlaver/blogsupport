package com.song.blogsupport.comment;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created by 001844 on 2018/4/24.
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class CommentServiceTest {

    @Autowired
    private CommentService commentService;

    @Test
    public void addTest() {
        CommentVo commentVo = new CommentVo();
        commentVo.setName("sx");
        commentVo.setEmail("504252262@qq.com");
        commentVo.setWebsite("http://3gods.com");
        commentVo.setId(127);
        commentVo.setContent("真是一篇好文章啊");
        commentVo.setBlogTitle("Learn-More-Study-Less-Note");
        commentVo.setCreateTime(new Date());
        commentVo.setAvatar("xxx");
        int i = commentService.add(commentVo);

    }


    @Test
    public void listTest() {
        String blogTitle = "Learn-More-Study-Less-Note";
        List<CommentVo> comments = commentService.list(blogTitle);
        System.out.println(Arrays.toString(comments.toArray()));
//        Assert.assertTrue(comments != null && comments.size() > 0);

    }
}
