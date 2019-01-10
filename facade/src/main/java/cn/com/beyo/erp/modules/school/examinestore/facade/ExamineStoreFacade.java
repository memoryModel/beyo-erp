package cn.com.beyo.erp.modules.school.examinestore.facade;

import cn.com.beyo.erp.commons.facade.BeyoFacade;
import cn.com.beyo.erp.commons.persistence.Page;
import cn.com.beyo.erp.commons.utils.RpcHttp;
import cn.com.beyo.erp.modules.school.examinestore.entity.ExamineStore;

import java.util.List;

public interface ExamineStoreFacade extends BeyoFacade<ExamineStore> {

    List<ExamineStore> findStoreList();

    String saveExamineStore(ExamineStore examineStore, String examJson);

    Page<ExamineStore> findPageList(ExamineStore examineStore,RpcHttp rpcHttp);
}
