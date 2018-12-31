<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>班级管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var currentClassId;
		$(document).ready(function() {

		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

        function selectClass(classId,className){
			var currentClassId = $("#currentClassId").val();
            top.$.jBox.confirm('确认要选择转班吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectClassCallback($("#erpStudentEnrollId").val(),currentClassId,classId,className);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
        }
	</script>
</head>
<body>

	<form:form id="searchForm" modelAttribute="schoolClass" action="${ctx}/school/studentInfo/selectClass" method="post" class="breadcrumb form-search">
		<input id="currentClassId" type="hidden" value="${currentClassId}"/>
		<input type="hidden" value="${erpStudentEnrollId}" id="erpStudentEnrollId">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>班级名称：</label>
				<input type="text" name ="className" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>课程名称：</label>
				<input type="text" name ="schoolClassToLesson.schoolClassLesson.lessonName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>班主任：</label>
				<input type="text" name ="headteacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" style="width:100px;"/></li>
			<li class="clearfix"></li>
		</ul>

	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
				<th>班级名称</th>
				<%--<th>课程</th>--%>
				<th>学费</th>
				<th>班主任</th>
				<th>人数</th>
				<th>班级状态</th>
				<th>操作</th>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="schoolClass">
			<tr>

				<td>
						${schoolClass.className}
				</td>
				<%--<td>
						${schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}
				</td>--%>
				<td>
						${schoolClass.tuitionAmount}
				</td>
				<td>
						${schoolClass.headteacher.name}
				</td>
				<td>
						${0 == schoolClass.classRealNum ? '':schoolClass.classRealNum}
						${0 == schoolClass.classRealNum ? '':'/'}
						${0 == schoolClass.classRealNum ? '':schoolClass.classMaxNum}<%--人数--%>
				</td>
				<td>
						${erp:classPlanStatusName(schoolClass.status)}${erp:classStatusName(schoolClass.status)}
				<td>
				<input id="btnSelect" onclick="selectClass('${schoolClass.id}','${schoolClass.className}')" href="javascript:; "
					   class="btn btn-primary" type="button" value="转入"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>