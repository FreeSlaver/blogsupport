package com.song.blogsupport.baiduindex;

import com.song.blogsupport.baiduindex.dao.BaiduIndexDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by 001844 on 2018/6/16.
 */
@Service
public class BaiduIndexService {
    @Autowired
    private BaiduIndexDao baiduIndexDao;


    public BaiduIndexVo getByDomain(String domainName) {
        return baiduIndexDao.selectByDomain(domainName);
    }

    public int insert(BaiduIndexVo insertVo) {
        return baiduIndexDao.insert(insertVo);
    }
}
