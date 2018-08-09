package com.song.blogsupport.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.validator.routines.DomainValidator;
import org.apache.commons.validator.routines.UrlValidator;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by 001844 on 2018/6/16.
 */
@Slf4j
public class HTTPUtil {
    public static String get(String url) throws IOException {
        return get(url,null);
    }
    public static String get(String url,String cookie) throws IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet get = new HttpGet(url);
        get.addHeader("Cookie",cookie);
        HttpEntity respEntity = null;
        try {
            log.info("HttpUtil GET REQUEST,url:{}", url);
            CloseableHttpResponse response = httpclient.execute(get);
            int statusCode = response.getStatusLine().getStatusCode();
            respEntity = response.getEntity();
            String respContent = null;
            if (respEntity != null) {
                respContent = IOUtils.toString(respEntity.getContent(), "UTF-8");
            }
            log.info("HttpUtil GET RESPONSE,statusCode:{},resp:{}", statusCode, respContent);
            if (statusCode != 200) {
                log.error("HttpUtil GET fail,statusCode:{},resp:{}", statusCode, respContent);
                return null;
            }
            return respContent;
        } catch (ClientProtocolException e) {
            log.error(e.getMessage(), e);
            throw e;
        } catch (IOException e) {
            log.error(e.getMessage(), e);
            throw e;
        } finally {
            EntityUtils.consume(respEntity);
        }
    }

    public static boolean checkGithubPagesUrl(String url) throws Exception {
        if (StringUtils.isEmpty(url)) {
            throw new IllegalArgumentException("url 为空");
        }
        return urlValid(url) && url.contains(".github.io");
    }

    public static boolean urlValid(String url) throws Exception {
        String[] schemes = {"http", "https"}; // DEFAULT schemes = "http", "https", "ftp"
        UrlValidator urlValidator = new UrlValidator(schemes);
        return urlValidator.isValid(url);
    }

    //校验那个ip
    public static boolean urlReachable(String url, Map<String, String> headers) throws IOException {
        try {
            URL aUrl = new URL(url);
            HttpURLConnection urlConn = (HttpURLConnection) aUrl.openConnection();
            if (headers != null && !headers.isEmpty()) {
                for (Map.Entry<String, String> header : headers.entrySet()) {
                    String k = header.getKey();
                    String v = header.getValue();
                    urlConn.setRequestProperty(k, v);
                }
            }
            urlConn.connect();
            int code = urlConn.getResponseCode();
            String remoteAddr = urlConn.getHeaderField("remote_addr");
            if (code != HttpURLConnection.HTTP_OK && "198.74.48.82".equalsIgnoreCase(remoteAddr)) {
                return true;
            }
        } catch (IOException e) {
            log.error(e.getMessage(), e);
            throw e;
        }
        return false;
    }

    public static boolean urlReachable(String url) throws IOException {
        return urlReachable(url, null);
    }

    public static boolean checkDomain(String domainName) {
        return DomainValidator.getInstance().isValid(domainName);
    }

    public static void main(String[] args) throws Exception {
        //被301重定向后访问不了
        String url = "http://3gods.com";
//        String url = "http://fatecome.com";
        Map<String, String> headers = new HashMap<>();
//        headers.put("User-Agent", "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)");
        //妈的，可以这样玩，设置ip
//        headers
//        urlReachable(url, headers);//所以我这种就失败了
//        InetAddress[] ias = InetAddress.getAllByName("fatecome.com");
//        System.out.println(Arrays.toString(ias));
//        String result = get(url);
//        System.out.println(result);
        String url2 = "https://fuckthejob.github.io";
        boolean result = checkGithubPagesUrl(url2);
        System.out.println(result);
    }
}
