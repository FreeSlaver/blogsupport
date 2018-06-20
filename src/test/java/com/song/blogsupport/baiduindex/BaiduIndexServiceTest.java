package com.song.blogsupport.baiduindex;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

/**
 * Created by 001844 on 2018/6/16.
 */
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class BaiduIndexServiceTest {

    @Autowired
    private BaiduIndexService baiduIndexService;

    @Test
    public void testGetByDomain() {
        String domain = "fatecome.com";
        BaiduIndexVo baiduIndexVo = baiduIndexService.getByDomain(domain);
        System.out.println(baiduIndexVo.toString());
    }

    @Test
    public void testInsert() {
        String domain = "fatecome.com";
        String code = "test123456";
        BaiduIndexVo insertVo = new BaiduIndexVo();
        insertVo.setDomainName(domain);
        insertVo.setCreateTime(new Date());
        insertVo.setVerifyCode(code);
        int i = baiduIndexService.insert(insertVo);
        System.out.println("i:" + i);
    }
}
