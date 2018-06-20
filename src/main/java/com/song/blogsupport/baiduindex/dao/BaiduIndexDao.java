package com.song.blogsupport.baiduindex.dao;

import com.song.blogsupport.baiduindex.BaiduIndexVo;

public interface BaiduIndexDao {
    int deleteByPrimaryKey(Integer id);

    int insert(BaiduIndexVo record);

    int insertSelective(BaiduIndexVo record);

    BaiduIndexVo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BaiduIndexVo record);

    int updateByPrimaryKey(BaiduIndexVo record);

    BaiduIndexVo selectByDomain(String domainName);
}