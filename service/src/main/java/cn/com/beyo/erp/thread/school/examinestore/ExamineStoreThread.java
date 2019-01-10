package cn.com.beyo.erp.thread.school.examinestore;

import cn.com.beyo.erp.commons.redis.Redis;
import cn.com.beyo.erp.commons.redis.RedisKey;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;


public class ExamineStoreThread implements Runnable {

    /**
     * 日志对象
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    private Redis redis;

    private String redisKey;

    private Map map;

    private String flag;

    public ExamineStoreThread(Redis redis, String redisKey,Map map,String flag){
        this.redis = redis;
        this.redisKey = redisKey;
        this.map = map;
        this.flag = flag;
    }

    @Override
    public void run() {
        try{
            if("sortedSet".equals(flag)){
                redis.zadd(RedisKey.SORTEDSET_EXAMINE_STORE,map);
            }else if("hash".equals(flag)){
                redis.hmset(RedisKey.HASH_EXAMINE_STORE_QUESTION,map);
            }
            //设置标识符
            //当 key RedisKey.FLAG_EXAMINE_STORE的value为2时，说明sortedSet和hash类型都添加成功
            //可以从redis查询
            redis.incr(RedisKey.FLAG_EXAMINE_STORE);
        }catch (Exception e){
            e.printStackTrace();
            logger.error(e.getMessage(),e);
        }
    }
}
