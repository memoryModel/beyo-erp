package cn.com.beyo.erp.commons.redis;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import redis.clients.jedis.*;

import java.util.*;

/**
 * Created by wanghw on 16/9/20.
 */
@Component
public class Redis{
    private final Logger logger = LoggerFactory.getLogger(Redis.class);

    /*private ShardedJedisPool shardedJedisPool;

    public Redis(ShardedJedisPool shardedJedisPool) {
        this.shardedJedisPool = shardedJedisPool;
    }*/

    private JedisPoolConfig jedisPoolConfig = null;

    private ShardedJedisPool shardedJedisPool;


    public Redis(){
        jedisPoolConfig = new JedisPoolConfig();
        jedisPoolConfig.setMaxIdle(100);
        jedisPoolConfig.setMinIdle(8);
        jedisPoolConfig.setMaxTotal(60000);
        jedisPoolConfig.setTestOnBorrow(true);
        jedisPoolConfig.setMaxWaitMillis(10000);
        jedisPoolConfig.setTestWhileIdle(true);
        jedisPoolConfig.setNumTestsPerEvictionRun(10);
        jedisPoolConfig.setTimeBetweenEvictionRunsMillis(30000);
        jedisPoolConfig.setMinEvictableIdleTimeMillis(60000);

        List<JedisShardInfo> list = new ArrayList<>();
        list.add(new JedisShardInfo("redis://39.107.103.183:6379"));

        shardedJedisPool = new ShardedJedisPool(jedisPoolConfig,list);

    }




    private void returnResource(ShardedJedis shardedJedis){
        if (null==shardedJedis)return;
        shardedJedis.close();
    }

    /**
     * 设置key过期时间
     * */
    public long expire(String key, int seconds) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();

            return shardedJedis.expire(key, seconds);
        } catch (Exception ex) {
            logger.error("redis expire error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    /**
     * 添加到Set列表中
     */
    public boolean sadd(String key, String... value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            shardedJedis.sadd(key, value);
            return true;
        } catch (Exception ex) {
            logger.error("redis sadd error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * 移除Set列表中对象
     */
    public boolean srem(String key, String... value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            shardedJedis.srem(key, value);
            return true;
        } catch (Exception ex) {
            logger.error("redis srem error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }

    /**
     * 获取Set列表
     */
    public  Set<String> smembers(String key){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.smembers(key);
        } catch (Exception ex) {
            logger.error("redis smembers error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 查找keys*
     */

    public Set<String> keys(String pattern) {
        ShardedJedis shardedJedis = null;
        Set<String> retList = new HashSet<>();
        try {
            shardedJedis = shardedJedisPool.getResource();
            Collection<Jedis> jedisCollection = shardedJedis.getAllShards();
            for(Jedis jedis : jedisCollection){
                retList.addAll(jedis.keys(pattern));
            }
        } catch (Exception ex) {
            logger.error("redis hkeys error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return retList;
    }
    /**
     * 保存对象
     * */
    public boolean set(String key, Object value) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] obj = SerializeUtil.serialize(value);
            if(null==obj)return false;
            shardedJedis.set(key.getBytes(), obj);
            return true;
        } catch (Exception ex) {
            logger.error("redis set error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    public Object get(String key) {
        return get(key,null);
    }
    /**
     * 取得对象
     * */
    public Object get(String key,Object defaultValue) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            byte[] value = shardedJedis.get(key.getBytes());
            if (null==value)return defaultValue;

            return SerializeUtil.unserialize(value);
        } catch (Exception ex) {
            logger.error("redis get error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }

        return defaultValue;
    }
    /**
     * 删除对象
     * */
    public boolean del(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.del(key) >0 ;
        } catch (Exception ex) {
            logger.error("redis del error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }

    /**
     * 删除对象
     * */
    public boolean remove(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.del(key.getBytes()) >0 ;
        } catch (Exception ex) {
            logger.error("redis del error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * 计数器-增加
     * */
    public long incr(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.incr(key);
        } catch (Exception ex) {
            logger.error("redis incr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }
    /**
     * 计数器-减少
     * */
    public long decr(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.decr(key);
        } catch (Exception ex) {
            logger.error("redis decr error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0;
    }

    /**
     * value是否是列表成员
     * */
    public boolean sismember(String key,String value) {
        if (null==value)return false;
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.sismember(key,value);
        } catch (Exception ex) {
            logger.error("redis sismember error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }
    /**
     * key是否存在
     * */
    public boolean exists(String key) {
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.exists(key);
        } catch (Exception ex) {
            logger.error("redis exists error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return false;
    }

   /**
     * 分布式锁 加锁
     * @param acquireTimeout 获取锁之前的超时时间 单位：毫秒
     * @param timeOut 获取锁之后的超时时间 单位：毫秒
     * @param lockKey 加锁的key
     * @param lockValue 加锁的value
     * */
    public boolean getLock(Long acquireTimeout,Long timeOut,String lockKey,String lockValue){
        if(StringUtils.isBlank(lockKey) || StringUtils.isBlank(lockValue)){
            return false;
        }
        ShardedJedis shardedJedis = null;
        try{
            shardedJedis = shardedJedisPool.getResource();
            //获取锁后的超时时间转换为秒
            int expireLockTime = (int)(timeOut / 1000);
            Long endTime = System.currentTimeMillis() + acquireTimeout;
            //保证在设置acquireTimeout时间内如果没有获得到锁的话，进行不断的获取
            while(endTime >= System.currentTimeMillis()){
                //使用sexnx命令插入key为lockKey，成功返回1，失败返回0
                if(shardedJedis.setnx(lockKey,lockValue) == 1){
                    //获取成功后，要设置锁的超时时间，防止死锁
                    shardedJedis.expire(lockKey,expireLockTime);
                    return true;
                }
            }
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            returnResource(shardedJedis);
        }
    }

    /**
     * 分布式锁 解锁
     * @param lockKey 加锁的key
     * @param lockValue 加锁的value
     * */
    public boolean unLock(String lockKey,String lockValue){
        if(StringUtils.isBlank(lockKey) || StringUtils.isBlank(lockValue)){
            return false;
        }
        ShardedJedis shardedJedis = null;
        try{
            shardedJedis = shardedJedisPool.getResource();
            if(lockValue.equals(shardedJedis.get(lockKey))){
                shardedJedis.del(lockKey);
                return true;
            }
            return false;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }finally {
            returnResource(shardedJedis);
        }
    }

    /**
     * 计数器 用于MQ去重
     * */
    public Long incrMQ(String key,Long timeOut){
        if(StringUtils.isBlank(key))return null;
        ShardedJedis shardedJedis = null;
        try{
            shardedJedis = shardedJedisPool.getResource();
            Long res = shardedJedis.incr(key);
            if(res == 1){
                shardedJedis.expire(key,(int)(timeOut / 1000));
            }
            return res;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public Long getMQ(String key){
        if(StringUtils.isBlank(key))return null;
        ShardedJedis shardedJedis = null;
        try{
            shardedJedis = shardedJedisPool.getResource();
            return Long.parseLong(shardedJedis.get(key));
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 添加sortedSet类型(单个添加)
     * */
    public Long zadd(String key,
                     double score,
                     String member){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zadd(key,score,member);
        } catch (Exception ex) {
            logger.error("redis zadd error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }
    /**
     * 添加sortedSet类型(批量添加)
     * */
    public Long zadd(String key,
                     Map<String, Double> scoreMembers){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zadd(key,scoreMembers);
        } catch (Exception ex) {
            logger.error("redis zadd error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }

    /**
     *查看sortedSet类型,按score 值递减(从大到小)来排列
     * */
    public Set zrevrange(String key,
                         long start,
                         long end){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zrevrange(key,start,end);
        } catch (Exception ex) {
            logger.error("redis zrevrange error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 移除有序集 key 中，指定排名(rank)区间内的所有成员。
     * 区间分别以下标参数 start 和 stop 指出，包含 start 和 stop 在内
     * */
    public Long zremrangebyrank(String key, long start, long end){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zremrangeByRank(key,start,end);
        } catch (Exception ex) {
            logger.error("redis zremrangebyrank error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;

    }

    /**
     * 返回有序集 key的数量
     * */
    public Long zcard(String key){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zcard(key);
        } catch (Exception ex) {
            logger.error("redis zcard error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }

    /**
     * 移除有序集 key 中的一个或多个成员，不存在的成员将被忽略
     * */
    public Long zrem(String key, String... members){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.zrem(key,members);
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error("redis zrem error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }

    /**
     * 将哈希表 key 中的域 field 的值设为 value
     * */
    public Long hset(String key, String field, String value){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.hset(key,field,value);
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error("redis hset error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }

    /**
     * 返回哈希表 key 中给定域 field 的值
     * */
    public String hget(String key, String field){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.hget(key,field);
        } catch (Exception ex) {
            logger.error("redis hget error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 同时将多个 field-value (域-值)对设置到哈希表 key 中
     * */
    public String hmset(String key, Map<String, String> hash){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.hmset(key,hash);
        } catch (Exception ex) {
            logger.error("redis hmset error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 返回哈希表 key 中，一个或多个给定域的值。
     * */
    public List<String> hmget(String key, String... fields){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.hmget(key,fields);
        } catch (Exception ex) {
            logger.error("redis hmget error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return null;
    }

    /**
     * 删除哈希表 key 中的一个或多个指定域，不存在的域将被忽略
     * */
    public Long hdel(String key, String... fields){
        ShardedJedis shardedJedis = null;
        try {
            shardedJedis = shardedJedisPool.getResource();
            return shardedJedis.hdel(key,fields);
        } catch (Exception ex) {
            logger.error("redis hdel error.", ex);
            returnResource(shardedJedis);
        } finally {
            returnResource(shardedJedis);
        }
        return 0L;
    }
}
