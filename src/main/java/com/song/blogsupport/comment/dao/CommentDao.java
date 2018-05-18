package com.song.blogsupport.comment.dao;

import com.song.blogsupport.comment.CommentVo;

import java.util.List;

public interface CommentDao {
    int deleteByPrimaryKey(Integer id);

    int insert(CommentVo record);

    int insertSelective(CommentVo record);

    CommentVo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(CommentVo record);

    int updateByPrimaryKey(CommentVo record);

    List<CommentVo> selectByBlogTitle(String blogTitle);
}