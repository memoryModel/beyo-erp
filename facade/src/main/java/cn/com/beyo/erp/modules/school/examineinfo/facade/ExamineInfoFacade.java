package cn.com.beyo.erp.modules.school.examineinfo.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.modules.school.examineinfo.entity.ExamineInfo;

import java.util.List;

public interface ExamineInfoFacade extends BeyoFacade<ExamineInfo> {

    void updateStatus(ExamineInfo examineInfo);

    List<ExamineInfo> findInfoName();

    List<ExamineInfo> findExamInfoBySchedule(ExamineInfo examineInfo);

    int updateInfoStatus(ExamineInfo examineInfo);

    int updateExamStore(ExamineInfo examineInfo);
}
