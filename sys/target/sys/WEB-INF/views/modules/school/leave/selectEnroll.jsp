<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
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


        function selectEnroll(studentId,name,studentNumber,phone){
            top.$.jBox.confirm('确认要选择添加该学员吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectEnrollCallback(studentId,name,studentNumber,phone);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
            //close
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="student" action="${ctx}/school/leave/selectEnroll" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学员姓名：</label>
				<form:input path="name" style="width:200px" placeholder="请输入学员姓名/学号/手机号" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学号</th>
				<th>学生姓名</th>
				<th>学生性别</th>
				<th>手机号码</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpStudentEnroll">
			<tr>
				<td>
					${erpStudentEnroll.studentNumber}
				</td>
				<td>
					${erpStudentEnroll.name}
				</td>
				<td>
					${erp:sexStatusName(erpStudentEnroll.sex)}
				</td>
				<td>
					${erpStudentEnroll.phone}
				</td>
				<td>
					${erp:studentStatusName(erpStudentEnroll.status)}
				</td>
				<td>
					<shiro:hasPermission name="school:leave:selectEnroll"><a id="btnSelect" class="btn btn-primary" onclick="selectEnroll('${erpStudentEnroll.id}','${erpStudentEnroll.name}','${erpStudentEnroll.studentNumber}','${erpStudentEnroll.phone}')"
																			 href="javascript:; ">添加学员</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>