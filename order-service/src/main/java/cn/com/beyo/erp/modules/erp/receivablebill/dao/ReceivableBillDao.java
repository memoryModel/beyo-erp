/**
 * Copyright &copy; 2017 beyo.com.cn All rights reserved.
 */
package cn.com.beyo.erp.modules.erp.receivablebill.dao;

import cn.com.beyo.erp.commons.persistence.BeyoDao;
import cn.com.beyo.erp.commons.persistence.annotation.MyBatisDao;
import cn.com.beyo.erp.modules.erp.receivablebill.entity.ReceivableBill;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 应收账单DAO接口
 * @author Ashon
 * @version 2017-06-28
 */
@MyBatisDao
public interface ReceivableBillDao extends BeyoDao<ReceivableBill> {

    /**
     * 收款单分页
     * @param erpReceivableBill
     * @author Ashon
     * @version 2017-08-07
     */
    List<ReceivableBill> findPayBillList(ReceivableBill erpReceivableBill);
    /*欠款管理*/
    List<ReceivableBill> findPageByPayStatus(ReceivableBill erpReceivableBill);
    /*欠款管理*/
    ReceivableBill getErpReceiveBillById(Long id);

    public ReceivableBill getById(ReceivableBill erpReceivableBill);
    /*账单挂起功能*/
    public void freeze(ReceivableBill erpReceivableBill);
    /*账单解挂功能*/
    public void unlock(ReceivableBill erpReceivableBill);
    /*确认收入功能*/
    public void affirm(ReceivableBill erpReceivableBill);

    public ReceivableBill getByOrderId(ReceivableBill erpReceivableBill);

    public ReceivableBill findReceivableBillByOrder(ReceivableBill receivableBill);

    int updateStatusByOrderId(ReceivableBill receivableBill);

    int updateStatusByorderIds(@Param("receivableBill") ReceivableBill receivableBill, @Param("idList") List<Long> idList);
}