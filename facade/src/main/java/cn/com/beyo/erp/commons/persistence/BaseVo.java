package cn.com.beyo.erp.commons.persistence;

import cn.com.beyo.erp.commons.supcan.annotation.treelist.SupTreeList;
import cn.com.beyo.erp.commons.supcan.annotation.treelist.cols.SupCol;
import cn.com.beyo.erp.modules.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import com.google.common.collect.Maps;

import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Map;

/**
 * Created by wanghw on 2017/5/31.
 */
@SupTreeList
public abstract class BaseVo<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    protected Long id;

    /**
     * 当前实体分页对象
     */
    protected Page<T> page;

    /**
     * 当前用户
     */
    protected User currentUser;

    /**
     * 自定义SQL（SQL标识，SQL内容）
     */
    protected Map<String, String> sqlMap;

        public BaseVo(){

    }

    public BaseVo(Long id){
        this();
        this.id = id;
    }

    @JsonSerialize(using=ToStringSerializer.class)
    @SupCol(isUnique="true", isHide="true")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    @JsonIgnore
    @XmlTransient
    public Page<T> getPage() {
        if (page == null){
            page = new Page<T>();
        }
        return page;
    }

    public Page<T> setPage(Page<T> page) {
        this.page = page;
        return page;
    }

    @JsonIgnore
    @XmlTransient
    public Map<String, String> getSqlMap() {
        if (sqlMap == null){
            sqlMap = Maps.newHashMap();
        }
        return sqlMap;
    }

    public void setSqlMap(Map<String, String> sqlMap) {
        this.sqlMap = sqlMap;
    }
}
