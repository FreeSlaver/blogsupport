package com.song.blogsupport.baiduindex;

import com.alibaba.fastjson.JSON;

import java.util.Date;

public class BaiduIndexVo {
    private Integer id;

    private String domainName;

    private String verifyCode;

    private Boolean verifyStatus;

    private String resolveAddr;

    private String githubPagesUrl;

    private Date createTime;

    private Date updateTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDomainName() {
        return domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName == null ? null : domainName.trim();
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode == null ? null : verifyCode.trim();
    }

    public Boolean getVerifyStatus() {
        return verifyStatus;
    }

    public void setVerifyStatus(Boolean verifyStatus) {
        this.verifyStatus = verifyStatus;
    }

    public String getResolveAddr() {
        return resolveAddr;
    }

    public void setResolveAddr(String resolveAddr) {
        this.resolveAddr = resolveAddr == null ? null : resolveAddr.trim();
    }

    public String getGithubPagesUrl() {
        return githubPagesUrl;
    }

    public void setGithubPagesUrl(String githubPagesUrl) {
        this.githubPagesUrl = githubPagesUrl == null ? null : githubPagesUrl.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}