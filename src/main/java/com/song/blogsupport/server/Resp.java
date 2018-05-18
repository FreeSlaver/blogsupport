package com.song.blogsupport.server;

import com.alibaba.fastjson.JSON;

/**
 * Created by 001844 on 2018/4/22.
 */
public class Resp<T> {
    private int code;
    private String msg;

    private T data;

    public Resp() {
        this.code = 0;
        this.msg = "success";
    }

    public Resp(T data) {
        this();
        this.data = data;
    }

    public Resp(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }
}
