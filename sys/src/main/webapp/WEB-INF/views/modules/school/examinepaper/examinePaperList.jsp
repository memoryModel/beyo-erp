<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试卷管理管理</title>
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
		<li class="active"><a href="${ctx}/school/examinePaper/list">试卷管理列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="examinePaper" action="${ctx}/school/examinePaper/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>考试班级：</label>
				<form:select path="classStudents.schoolClass.id" style="width:210px" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${classList}" itemLabel="className" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>学员姓名：</label>
				<form:input path="classStudents.student.name"  placeholder="请输入学员姓名/学号"  htmlEscape="false" maxlength="20" style="width:195px" class="input-medium"/>
			</li>
			<%--<li><label>考试课程：</label>
				<form:select path="classToLesson.schoolClassLesson.id" style="width: 210px" class="input-medium">
					<form:option value="">请选择</form:option>
					<form:options items="${lessonList}" itemLabel="lessonName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>--%>
			<li><label>考试名称：</label>
				<form:input path="examineInfo.examineName" htmlEscape="false" maxlength="20" style="width:195px" class="input-medium"/>
			</li>
			<li><label>考试类型：</label>
				<form:select  path="examineInfo.examineType" class="input-large" style="width: 210px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(25)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>考试方式：</label>
				<form:select path="examineInfo.examineMethod" class="input-large" style="width: 210px">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(26)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
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
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolExaminePaper">
			<tr createUser="${schoolExaminePaper.createUser}" id="${schoolExaminePaper.id}">
				<td>
					${schoolExaminePaper.student.name}
				</td>
				<td>
					${schoolExaminePaper.student.studentNumber}
				</td>
				<td>
					${schoolExaminePaper.classStudents.schoolClass.className}
				</td>
				<td>
					${schoolExaminePaper.examineInfo.examineName}
				</td>
				<td>
					${erp:examTypeName(schoolExaminePaper.examineInfo.examineType)}
				</td>
				<%--<td>
					${schoolExaminePaper.classToLesson.schoolClassLesson.lessonName}
				</td>--%>
				<td>
					${erp:getCommonsTypeName(schoolExaminePaper.examineInfo.examineMethod)}
				</td>
				<td>
					<fmt:formatDate value="${schoolExaminePaper.examineInfo.startTime}" pattern="yyyy-MM-dd HH:mm"/>~<br/>
					<fmt:formatDate value="${schoolExaminePaper.examineInfo.endTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${schoolExaminePaper.examineInfo.examineLength}&nbsp;分钟
				</td>
				<td>
					<fmt:formatDate value="${schoolExaminePaper.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<shiro:hasPermission name="school:examinePaper:info"><a href="${ctx}/school/examinePaper/view?id=${schoolExaminePaper.id}">查看试卷</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
<script src="${ctxStatic}/officeNames/officeNames.js" type="text/javascript"></script>
</body>
</html>