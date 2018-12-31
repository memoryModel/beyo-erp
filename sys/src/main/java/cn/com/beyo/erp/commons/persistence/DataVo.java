package cn.com.beyo.erp.commons.persistence;

import cn.com.beyo.erp.commons.status.Status;
import cn.com.beyo.erp.commons.utils.IdWorker;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Date;

/**
 * Created by wanghw on 2017/5/31.
 */
public abstract class DataVo<T> extends BaseVo<T> {

    protected Long createUser;	// 创建者
    protected Date createTime;	// 创建日期
    protected Date updateTime;	// 更新日期
    protected Integer status;	// 状态
    protected Long platformId;

    public DataVo(){

    }
    public DataVo(Long id){
        super();
        this.id = id;
    }

    public void nextId()throws Exception{
        this.id = IdWorker.getFlowIdWorkerInstance().nextId();
    }


    @JsonIgnore
    public Long getCreateUser() {
        return createUser;
    }

    public void setCreateUser(Long createUser) {
        this.createUser = createUser;
    }

    @JsonIgnore
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @JsonIgnore
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getStatus() {
        return null==status? Status.NORMAL.getValue():status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @JsonIgnore
    public Long getPlatformId() {
        return platformId;
    }

    public void setPlatformId(Long platformId) {
        this.platformId = platformId;
    }
}
