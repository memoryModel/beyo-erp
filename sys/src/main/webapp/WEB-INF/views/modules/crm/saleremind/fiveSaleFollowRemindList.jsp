
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售线索管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {

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

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/saleRemind/list">今日新增</a></li>
		<li><a href="${ctx}/crm/saleRemind/followRemindList?selectDay=4">3日应跟进</a></li>
		<li class="active"><a href="${ctx}/crm/saleRemind/followRemindList?selectDay=2&&tagFlag=5">5日应跟进</a></li>
		<li ><a href="${ctx}/crm/saleRemind/followRemindList?selectDay=2">7日应跟进</a></li>
		<li><a href="${ctx}/crm/saleRemind/followRemindList?selectDay=8">15日应跟进</a></li>
		<li><a href="${ctx}/crm/saleRemind/monthSaleFollowList?selectDay=16">30日应跟进</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="sale" action="${ctx}/crm/saleRemind/followRemindList?selectDay=2&&tagFlag=${tagFlag}" method="post" class="breadcrumb form-search">
	<ul class="ul-form">
		<li>
			<label>意向业务：</label>
			<form:select path="serviceTypeId" class="input-medium">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
			</form:select>
		</li>
		<%--<li><label>销售顾问：</label>
			<sys:treeselect id="saleAdviserId" name="saleDelegateRecord.saleAdviserName.id" value="${sale.saleDelegateRecord.saleAdviserName.id}"
							labelName="saleDelegateRecord.saleAdviserName.name" labelValue="${sale.saleDelegateRecord.saleAdviserName.name}"
							title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true"/>
		</li>--%>
		<%--<li>
			<label>跟进结果：</label>
			<select name="gradeStatus" class="input-medium">
				<option value="">------请选择------</option>
				<option value="1" <c:if test="${!empty followStatus && followStatus == 1}">selected</c:if>>未跟进</option>
				<option value="2" <c:if test="${!empty gradeStatus && gradeStatus == 2}">selected</c:if>>已跟进</option>
			</select>
		</li>--%>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>客户名称</th>
			<th>线索来源</th>
			<th>重要程度</th>
			<th>负责人</th>
			<th>销售阶段</th>
			<th>跟进次数</th>
			<th>委派时间</th>
			<th>计划跟进日期</th>
			<th>跟进结果</th>
			<th>跟进时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sale">
			<tr>
				<td>
					<a name="customerView" customerId="${sale.customer.id}" href="javascript:;" >${sale.customer.name}</a>
				</td>
				<td>
						${sale.customerResource.customerName}
				</td>
				<td>
						${erp:getCommonsTypeName(sale.importantDegree)}
				</td>
				<td>
						${sale.saleDelegateRecord.saleAdviserName.name}
				</td>
				<td>
						${erp:getCommonsTypeName(sale.crmSaleFollow.followStage)}
				</td>
				<td>
						${sale.followNumber}
				</td>
				<td>
					<fmt:formatDate value="${sale.saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${sale.saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${erp:getFollowStatusName(sale.followRecordFunction)}
				</td>
				<td>
					<c:if test="${sale.followRecordFunction == 5 || sale.followRecordFunction == 7}">
						<fmt:formatDate value="${sale.crmSaleFollow.followTime}" pattern="yyyy-MM-dd HH:mm"/>
					</c:if>
				</td>
				<td>
					<shiro:hasPermission name="crm:saleFollow:form">
						<c:if test="${sale.followRecordFunction == 5}">
							<a href="${ctx}/crm/saleFollow/form?saleId=${sale.id}&&saleDelegateRecordId=${sale.saleDelegateRecord.id}">添加跟进记录</a>
						</c:if>
						<c:if test="${sale.followRecordFunction == 7}">
							<a href="${ctx}/crm/saleFollow/view?saleId=${sale.id}&&saleDelegateRecordId=${sale.saleDelegateRecord.id}&&tagFlag=2">查看跟进记录</a>
						</c:if>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>