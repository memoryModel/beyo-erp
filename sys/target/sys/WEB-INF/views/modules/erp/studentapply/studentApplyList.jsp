<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员报名管理</title>
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
		<li class="active"><a href="${ctx}/erp/studentApply/">学员报名列表</a></li>
		<shiro:hasPermission name="erp:StudentApply:form"><li><a href="${ctx}/erp/studentApply/form">学员报名添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erpStudentEnroll" action="${ctx}/erp/studentApply/save" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%--<li><label>班级名称：</label>
				<form:input path="schoolClassStudents.schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>--%>
		<%--	<li><label>创建时间：</label>
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${commonsType.startTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>至
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					   value="<fmt:formatDate value="${commonsType.endTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>状态：</label>
				<form:select path="status" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<%--<th>姓名</th>
			<th>性别</th>
			<th>出生年月</th>
			<th>手机号码</th>
			<th>身份证号码</th>
			<th>籍贯</th>
			<th>学历</th>
			<th>生活城市</th>
			<th>qq号码</th>
			<th>紧急联络人</th>
			<th>紧急联络电话</th>--%>
			<th>所属校区</th>
			<th>招生来源</th>
			<th>招聘老师</th>
			<th>推荐人</th>
			<th>报名时间</th>
			<th>是否住宿</th>
			<th>班级名称</th>
			<th>课程</th>
			<th>学费</th>
			<th>创建时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpStudentEnroll">
			<tr>
				<%--<td>
						${erpStudentEnroll.name}
				</td>
				<td>
						${erpStudentEnroll.sex}
				</td>
				<td>
						${erpStudentEnroll.dateBirth}
				</td>
				<td>
						${erpStudentEnroll.phone}
				</td>
				<td>
						${erpStudentEnroll.stuNumber}
				</td>
				<td>
						${erpStudentEnroll.nativePlace}
				</td>
				<td>
						${erpStudentEnroll.education}
				</td>
				<td>
						${erpStudentEnroll.stuCity}
				</td>
				<td>
						${erpStudentEnroll.qqNumber}
				</td>
				<td>
						${erpStudentEnroll.emergencyContact}
				</td>
				<td>
						${erpStudentEnroll.urgencyPhone}
				</td>--%>
				<td>
						${erpStudentEnroll.areas.areaName}
				</td>
				<td>
						${erpStudentEnroll.customerResource.customerName}
				</td>
				<td>
						${erpStudentEnroll.employee.name}
				</td>
				<td>
						${erpStudentEnroll.referrer.id}
				</td>
				<td>
						<fmt:formatDate value="${erpStudentEnroll.applyTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
						${erpStudentEnroll.dormitory}
				</td>
				<td>
						${erpStudentEnroll.schoolClassStudents.schoolClass.className}
				</td>
				<td>
						${erpStudentEnroll.schoolClassStudents.schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}
				</td>
				<td>
						${erpStudentEnroll.schoolClassStudents.schoolClass.tuitionAmount}
				</td>

				<td>
					    <fmt:formatDate value="${erpStudentEnroll.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--创建时间--%>
				</td>
				<td>
						${erp:commonsStatusName(erpStudentEnroll.status)}
				</td>
				<td>
					<shiro:hasPermission name="erp:studentApply:form"><a href="${ctx}/erp/studentApply/form?id=${erpStudentEnroll.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="erp:studentApply:delete"><a href="${ctx}/erp/studentApply/delete?id=${erpStudentEnroll.id}" onclick="return confirmx('确认要删除该单表吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>