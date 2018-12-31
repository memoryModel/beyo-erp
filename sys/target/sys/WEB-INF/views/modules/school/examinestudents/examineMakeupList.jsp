<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>成绩查询管理</title>
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
		<li class="active"><a href="${ctx}/school/examineStudents/makeupList">补考管理</a></li>
		<shiro:hasPermission name="school:examineInfo:form">
		<li><a href="/school/examineInfo/form?examineStatus=1">新增补考</a> </li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="examineStudents" action="${ctx}/school/examineStudents/makeupList" method="post" class="breadcrumb form-search">
		<form:hidden path="examineInfo.infoStatus"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学员姓名：</label>
				<form:input path="student.name"   placeholder="请输入学员姓名/学号"  htmlEscape="false" maxlength="20" class="input-xlarg"/>
			</li>
			<li><label>考试班级：</label>
				<form:input path="schoolClass.className"     htmlEscape="false" maxlength="20" class="input-xlarg"/>
			</li>
			<%--<li><label>考试课程：</label>
				<form:input path="classLesson.lessonName"     htmlEscape="false" maxlength="20" class="input-xlarg"/>
			</li>--%>
			<li class="clearfix"></li>
			<li><label>考试名称：</label>
				<form:input path="examineInfo.examineName"     htmlEscape="false" maxlength="20" class="input-xlarg"/>
			</li>
			<li><label>考试类型：</label>
				<form:select path="examineInfo.examineType" class="input-large" style="width: 210px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(25)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>

			<li class="clearfix"></li>
			<li><label>考试方式：</label>
				<form:select path="examineInfo.examineMethod" class="input-large" style="width: 210px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(26)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineStudents.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${examineStudents.createTimeEnd}" pattern="yyyy-MM-dd"/>"
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
				<th>姓名</th>
				<th>学号</th>
				<th>考试班级</th>
				<th>考试名称</th>
				<th>考试类型</th>
				<%--<th>考试课程</th>--%>
				<th>考试方式</th>
				<th>考试时段</th>
				<th>答题时长</th>
				<th>得分</th>
				<th>是否及格</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="examineStudents">
			<tr createUser="${examineStudents.createUser}" id="${examineStudents.id}">
				<td>
					${examineStudents.student.name}
				</td>
				<td>
					${examineStudents.student.studentNumber}
				</td>
				<td>
					${examineStudents.schoolClass.className}
				</td>
				<td>
					${examineStudents.examineInfo.examineName}
				</td>
				<td>
					${erp:examTypeName(examineStudents.examineInfo.examineType)}
				</td>
				<%--<td>
					${examineStudents.classLesson.lessonName}
				</td>--%>
				<td>
					${erp:getCommonsTypeName(examineStudents.examineInfo.examineMethod)}
				</td>
				<td>
					<fmt:formatDate value="${examineStudents.examineInfo.startTime}" pattern="yyyy-MM-dd HH:mm"/>~<br/>
					<fmt:formatDate value="${examineStudents.examineInfo.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${examineStudents.examineInfo.examineLength}分钟
				</td>
				<td>
					${examineStudents.grade}
				</td>
				<td>
					${erp:passStatusName(examineStudents.passStatus)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>