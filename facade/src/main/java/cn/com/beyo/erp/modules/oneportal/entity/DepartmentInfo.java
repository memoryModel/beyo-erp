package cn.com.beyo.erp.modules.oneportal.entity;

import cn.com.beyo.erp.commons.persistence.DataVo;

import java.io.Serializable;

public class DepartmentInfo extends DataVo<DepartmentInfo> {

    private String deptId; // 部门编码
    private String companyId; // 公司编号
    private String deptName; // 部门名称
    private String parentDeptId; // 父级部门
    private String createUserId; // 创建用户id
    private String deptLeader; // 部门负责人
    private String deptLeaderName; // 部门负责人名称
    private String appInfoList; // 部门分配的appInfo列表
    private String costCenter; // 成本中心
    private int level; // 树形层级
    private boolean leaf; // 是否有子级
    private  boolean expanded; // 用于标识在gridview控件中是否展开该节点
    private boolean updateSubdivision;//是否同步子部门

    private String parentDeptIds;   // 父级节点集合
    //dhrm_company
    private String dhrmCompany;

    public String getDhrmCompany() {
		return dhrmCompany;
	}

	public void setDhrmCompany(String dhrmCompany) {
		this.dhrmCompany = dhrmCompany;
	}

	public boolean isExpanded() {
        return expanded;
    }

    public void setExpanded(boolean expanded) {
        this.expanded = expanded;
    }

    public int getLevel() {
        return level;
    }

    public boolean isLeaf() {
        return leaf;
    }

    public void setLeaf(boolean leaf) {
        this.leaf = leaf;
    }

    public void setLevel(int level) {
        this.level = level;

    }

    public String getDeptLeaderName() {
        return deptLeaderName;
    }

    public void setDeptLeaderName(String deptLeaderName) {
        this.deptLeaderName = deptLeaderName;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getParentDeptId() {
        return parentDeptId;
    }

    public void setParentDeptId(String parentDeptId) {
        this.parentDeptId = parentDeptId;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    public String getDeptLeader() {
        return deptLeader;
    }

    public void setDeptLeader(String deptLeader) {
        this.deptLeader = deptLeader;
    }

    public String getAppInfoList() {
        return appInfoList;
    }

    public void setAppInfoList(String appInfoList) {
        this.appInfoList = appInfoList;
    }

    public String getCostCenter() {
        return costCenter;
    }

    public void setCostCenter(String costCenter) {
        this.costCenter = costCenter;
    }

    public String getParentDeptIds() {
        return parentDeptIds;
    }

    public void setParentDeptIds(String parentDeptIds) {
        this.parentDeptIds = parentDeptIds;
    }

    public boolean getUpdateSubdivision() {
        return updateSubdivision;
    }

    public void setUpdateSubdivision(boolean updateSubdivision) {
        this.updateSubdivision = updateSubdivision;
    }

    @Override
    public String toString() {
        return "DepartmentInfo{" +
                "deptId='" + deptId + '\'' +
                ", companyId='" + companyId + '\'' +
                ", deptName='" + deptName + '\'' +
                ", parentDeptId='" + parentDeptId + '\'' +
                ", createUserId='" + createUserId + '\'' +
                ", deptLeader='" + deptLeader + '\'' +
                ", deptLeaderName='" + deptLeaderName + '\'' +
                ", appInfoList='" + appInfoList + '\'' +
                ", costCenter='" + costCenter + '\'' +
                ", level=" + level +
                ", leaf=" + leaf +
                ", expanded=" + expanded +
                ", updateSubdivision=" + updateSubdivision +
                ", parentDeptIds='" + parentDeptIds + '\'' +
                ", dhrmCompany='" + dhrmCompany + '\'' +
                ", id=" + id +
                '}';
    }
}
