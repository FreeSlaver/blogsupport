package com.song.blogsupport.comment;

import com.song.blogsupport.comment.dao.CommentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 001844 on 2018/4/22.
 */
@Service
public class CommentService {

    @Autowired
    private CommentDao commentDao;


    public int add(CommentVo commentVo) {
        return commentDao.insert(commentVo);
    }


    public List<CommentVo> list(String blogTitle) {
        return commentDao.selectByBlogTitle(blogTitle);
    }
}
