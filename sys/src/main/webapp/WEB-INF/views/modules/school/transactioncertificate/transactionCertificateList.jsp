<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/school/transactionCertificate/list">证书办理</a></li>
	<shiro:hasPermission name="school:transactionCertificate:form"><li><a href="${ctx}/school/transactionCertificate/form">新增办理记录</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="transactionCertificate" action="${ctx}/school/transactionCertificate/list" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">

		<li><label>报读班级：</label>
			<form:input path="classStudents.schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>学生：</label>
			<form:input path="classStudents.student.name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>证书类型：</label>
			<form:input path="certificate.certificateName" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li><label>办理时间：</label>
			<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${transactionCertificate.createTimeStart}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
			<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
				   value="<fmt:formatDate value="${transactionCertificate.createTimeEnd}" pattern="yyyy-MM-dd"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>班级</th>
		<th>学员姓名</th>
		<th>学号</th>
		<th>手机号</th>
		<th>办理证书</th>
		<th>经办人</th>
		<th>办理时间</th>
		<th>操作</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="transactionCertificate">
		<tr createUser="${transactionCertificate.createUser}" id="${transactionCertificate.id}">
			<td>
					${transactionCertificate.classStudents.schoolClass.className}
				</a></td>
			<td>
					${transactionCertificate.classStudents.student.name}
			</td>
			<td>
					${transactionCertificate.classStudents.student.studentNumber}
			</td>
			<td>
					${transactionCertificate.classStudents.student.phone}
			</td>
			<td>
					${transactionCertificate.certificate.certificateName}
			</td>
			<td>
					${transactionCertificate.user.name}
			</td>
			<td>
				<fmt:formatDate value="${transactionCertificate.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					<%--<shiro:hasPermission name="school:transactionCertificate:form"><a href="${ctx}/school/transactionCertificate/form?id=${transactionCertificate.id}">修改</a></shiro:hasPermission>--%>
				<shiro:hasPermission name="school:transactionCertificate:delete"><a href="${ctx}/school/transactionCertificate/delete?id=${transactionCertificate.id}" onclick="return confirmx('确认要删除该学员办理的证书信息吗？', this.href)">删除</a></shiro:hasPermission>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>