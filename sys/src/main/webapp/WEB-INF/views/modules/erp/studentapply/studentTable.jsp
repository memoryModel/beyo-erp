<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>商品订单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        function selectStudent(id){

            top.$.jBox.confirm('确认要选择添加该学生吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectStudentCallback(id);

                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    top.$.jBox.close(true);
                }
            }});
        }
	</script>
</head>
<body>

<form:form id="searchForm" modelAttribute="student" action="${ctx}/erp/studentApply/studentTable" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input id="tagFlag" name="tagFlag" type="hidden" value="${tagFlag}"/>
	<ul class="ul-form">
		<li><label style="width: 100px">姓名/手机号：</label>
			<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<tr>
		<th>姓名</th>
		<th>性别</th>
		<th>手机号</th>
		<th>学历</th>
		<th>招聘老师</th>
		<th>紧急联系人</th>
		<th>操作</th>
	</tr>
	<tbody>
	<c:forEach items="${page.list}" var="student">
		<tr>
			<td>
					${student.name}
			</td>
			<td>
					${erp:sexStatusName(student.sex)}
			</td>
			<td>
					${student.phone}
			</td>
			<td>
					${erp:getCommonsTypeName(student.education)}
			</td>
			<td>
					${student.teacher.name}
			</td>
			<td>
					${student.emergencyContact}
			</td>
			<td>
				<a id="btnSelect" class="btn btn-primary" onclick="selectStudent('${student.id}')" href="javascript:; ">添加生源</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>