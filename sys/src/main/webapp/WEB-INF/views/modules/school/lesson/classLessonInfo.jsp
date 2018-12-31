<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>课程详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#asProCategoryButton").addClass("disabled");
            //$("#userButton").addClass("disabled");

        });
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/school/lesson/list">课程列表</a></li>
	<li class="active"><a href="${ctx}/school/lesson/info?id=${schoolClassLesson.id}">课程详情</a></li>
</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/school/lesson/info?id=${schoolClassLesson.id}">基本信息</a></li>
		<li><a href="${ctx}/school/lesson/lessonPlanInfo?lessonId=${schoolClassLesson.id}">授课计划</a></li>
	</ul></div><br/>


<form:form id="inputForm" modelAttribute="classLesson" class="form-horizontal">
	<form:hidden path="id"/>
	<table id="contentTable">
		<tr>
			<td>
				<div class="control-group">
					<label class="control-label">课程名称:</label>
					<div class="controls">
						<input value="${schoolClassLesson.lessonName}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
				<%--<td>
					<div class="control-group">
						<label class="control-label">科目:</label>
						<div class="controls">
							<input value="${schoolClassLesson.schoolSubject.subjectName}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>--%>
		</tr>
			<%--<tr>
				<td>
					<div class="control-group">
						<label class="control-label">年份:</label>
						<div class="controls">
							<input id="createTime" name="createTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">期段:</label>
						<div class="controls">
							<input id="creatTime" name="createTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${schoolClassLesson.createTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
			</tr>--%>
		<tr>

			<td>
				<div class="control-group">
					<label class="control-label">类型:</label>
					<div class="controls">
						<input value="${erp:getCommonsTypeName(classLesson.schoolLessonType)}" type="text" readonly="readonly" style="width:250px;"/>
							<%--<input value="${schoolClassLesson.status}" type="text" readonly="readonly" style="width:250px;"/>--%>
					</div>
				</div>
			</td>
			<td>
				<div class="control-group">
					<label class="control-label">授课老师:</label>
					<div class="controls">
						<input value="${schoolClassLesson.teacherNames}" type="text" readonly="readonly" style="width:250px;"/>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" rowspan="2">
				<div class="control-group">
					<label class="control-label">课程图片:</label>
					<div class="controls">
						<img src='${schoolClassLesson.photoUrl}@100w_100h'/>
					</div>
				</div>
			</td>
		</tr>
		<tr></tr>
		<tr>
			<td colspan="2">
				<div class="control-group">
					<label class="control-label">课程内容:</label>
					<div class="controls">
						<form:textarea path="lessonContent"  rows="4" disabled= "true" style="width:709px;"/>
					</div>
				</div>
			</td>
		</tr>
	</table>

</form:form>
</body>
</html>