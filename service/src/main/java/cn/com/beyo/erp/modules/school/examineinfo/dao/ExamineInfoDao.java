/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.school.examineinfo.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;

import java.util.List;

/**
 * 单表生成DAO接口
 * @author beyo.com.cn
 * @version 2017-06-08
 */
@MyBatisDao
public interface ExamineInfoDao extends BeyoDao<ExamineInfo> {

    public void insertInfo(ExamineInfo examineInfo);

    public void updateStatus(ExamineInfo examineInfo);

    public List<ExamineInfo> findInfoName(ExamineInfo examineInfo);

    List<ExamineInfo> findExamInfoBySchedule(ExamineInfo examineInfo);

    int updateInfoStatus(ExamineInfo examineInfo);

    int updateExamStore(ExamineInfo examineInfo);

}