
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

            $(document).find("a[name='saleForm']").each(function () {

                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/sale/selectDelegate?id="+id,
						{
                            title:"选择委派人",
                            width:500,
                            height:550,
							buttons:{}
						}
                    );
                });
            });

            $(document).find("a[name='customerView']").each(function () {
                var customerId = $(this).attr("customerId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                        title:"客户信息 ",
                        width:1100,
                        height:768,
                        buttons:{}
                    });
                });
            });
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
        function selectDelegatesCallback(){
            window.location.reload(true);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/sale/list">全部线索列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="sale" action="${ctx}/crm/sale/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>线索来源：</label>
				<sys:treeselect id="customerResource" name="customerResource.id" value="${sale.customerResource.id}"
								labelName="customerResource.customerName" labelValue="${sale.customerResource.customerName}"
								title="来源名称" url="/erp/customerResource/treeData" cssClass="required" allowClear="true"/>
			</li>
			<li>
				<label>意向业务：</label>
				<form:select path="serviceTypeId" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>意向门店：</label>

			</li>
			<li><label>重要程度：</label>
				<form:select path="importantDegree" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(54)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>vip客户：</label>
				<form:select path="vipFlag" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:findVipFlagList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>委派状态：</label>
				<form:select path="delegateStatus" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:delegateStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>跟进阶段：</label>
				<form:select path="crmSaleFollow.followStage" style="width: 150px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(9)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>线索状态：</label>
				<form:select path="clueStatus" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:findClueStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>客户意向：</label>
				<form:select path="crmSaleFollow.customerIntention" style="width: 150px;">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(49)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>销售顾问：</label>
				<sys:treeselect id="saleAdviserId" name="saleDelegateRecord.saleAdviserName.id" value="${sale.saleDelegateRecord.saleAdviserName.id}"
								labelName="saleDelegateRecord.saleAdviserName.name" labelValue="${sale.saleDelegateRecord.saleAdviserName.name}"
								title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
			</li>
			<li><label>委派人：</label>
				<sys:treeselect id="delegtatePersonId" name="saleDelegateRecord.delegtatePersonName.id" value="${sale.saleDelegateRecord.delegtatePersonName.id}"
								labelName="saleDelegateRecord.delegtatePersonName.name" labelValue="${sale.saleDelegateRecord.delegtatePersonName.name}"
								title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
			</li>
			<li><label>创建人：</label>
				<sys:treeselect id="createUser" name="createUserName.id" value="${sale.createUserName.id}"
								labelName="createUserName.name" labelValue="${sale.createUserName.name}"
								title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
			</li>
			<li><label>跟进状态：</label>
				<form:select path="followStatus" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:findFollowStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;首次跟进时间：
				<input name="firstFollowStartTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${sale.firstFollowStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="firstFollowEndTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${sale.firstFollowEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最后跟进时间：
				<input name="newFollowStartTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${sale.newFollowStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="newFollowEndTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${sale.newFollowEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/></li>

			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>客户名称</th>
			<th>意向业务</th>
			<th>线索来源</th>
			<th>重要程度</th>
			<th>VIP客户</th>
			<th>委派状态</th>
			<th>销售顾问</th>
			<th>跟进状态</th>
			<th>线索状态</th>
			<th>跟进阶段</th>
			<th>客户意向</th>
			<th>首次跟进时间</th>
			<th>最后跟进时间</th>
			<th>分派时间</th>
			<th>创建时间</th>
			<th>委派人</th>
			<th>创建人</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="crmSale">
			<tr>
				<td>
					<a name="customerView" customerId="${crmSale.customer.id}" href="javascript:;" >${crmSale.customer.name}</a>
				</td>
				<td>
						${erp:getCommonsTypeName(crmSale.serviceTypeId)}
				</td>
				<td>
						${crmSale.customerResource.customerName}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSale.importantDegree)}
				</td>
				<td>
						<c:if test="${crmSale.vipFlag == 0}">
							是
						</c:if>
						<c:if test="${crmSale.vipFlag == 1}">
							否
						</c:if>
				</td>
				<td>
						${erp:delegateStatusName(crmSale.delegateStatus)}
				</td>
				<td>
						${crmSale.saleDelegateRecord.saleAdviserName.name}
				</td>
				<td>
						${erp:getFollowStatusName(crmSale.followStatus)}
				</td>
				<td>
					${erp:getClueStatusName(crmSale.clueStatus)}
				</td>
				<td>
						${erp:getCommonsTypeName(crmSale.crmSaleFollow.followStage)}
				</td>
				<td>
					${erp:getCommonsTypeName(crmSale.crmSaleFollow.customerIntention)}
				</td>
				<td>
					<fmt:formatDate value="${crmSale.crmSaleFollow.followTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${crmSale.newFollowTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${crmSale.saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${crmSale.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${crmSale.saleDelegateRecord.delegtatePersonName.name}
				</td>
				<td>
						${crmSale.createUserName.name}
				</td>
				<td>
						<shiro:hasPermission name="crm:sale:saleInfo"><a href="${ctx}/crm/sale/saleInfo?id=${crmSale.id}&&tagFlag=1">查看</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>