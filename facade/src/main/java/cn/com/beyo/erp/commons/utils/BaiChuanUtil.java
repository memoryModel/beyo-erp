package cn.com.beyo.erp.commons.utils;

import cn.com.beyo.erp.commons.config.Global;
import com.alibaba.media.MediaConfiguration;
import com.alibaba.media.MediaFile;
import com.alibaba.media.Result;
import com.alibaba.media.client.MediaClient;
import com.alibaba.media.client.impl.DefaultMediaClient;
import org.apache.log4j.Logger;

import java.io.File;
import java.io.InputStream;

/**
 * Created by wanghw on 2017/7/11.
 */
public class BaiChuanUtil {
    private final static Logger log = Logger.getLogger(BaiChuanUtil.class);

    private static MediaConfiguration configuration = new MediaConfiguration();

    private static MediaClient client;

    static {
        configuration.setAk("24541729");
        configuration.setSk("70c033e5e3e86816ad9c0cc4600ce66b");
        configuration.setNamespace(Global.getCloudPublicSpace());
        client = new DefaultMediaClient(configuration);

        // 3. 定义上传策略
        //UploadPolicy uploadPolicy = new UploadPolicy();
        //uploadPolicy.setInsertOnly(UploadPolicy.INSERT_ONLY_NONE);
        //uploadPolicy.setExpiration(System.currentTimeMillis() + 3600 * 1000);
    }

    public static boolean upload(String var1, String var2, InputStream var3, long var4)throws Exception{
        Result<MediaFile> result =  client.upload(var1,var2, var3,var4);
        //log.info(result.getMessage());
        //log.info(result.getHttpStatus());
        //log.info(result.toString());
        if (null==result)return false;
        return result.isSuccess();
    }
    public static boolean upload(String var1, String var2, File var3)throws Exception{
        Result<MediaFile> result =  client.upload(var1,var2, var3);
        //log.info(result.getMessage());
        //log.info(result.getHttpStatus());
        //log.info(result.toString());
        if (null==result)return false;
        return result.isSuccess();
    }


}
