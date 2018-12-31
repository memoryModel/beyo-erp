<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>onePortal</title>
	<meta name="decorator" content="default"/>

</head>
<body>
<ul class="nav nav-tabs">
</ul>
<form:form id="searchForm" modelAttribute="userInfo" action="${ctx}/oneportal/list"
		   method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
</form:form>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<th>姓名</th>
	<th>员工号</th>
	<th>部门</th>
	<th>出勤天数</th>
	<th>正常打卡/次</th>
	<th>迟到次数</th>
	<th>旷工次数</th>
	<th>早退次数</th>
	<th>缺卡次数</th>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="userInfo">
		<tr >
			<td>
					${userInfo.userName}
			</td>
			<td>
					${userInfo.employeNo}
			</td>
			<td>
					${userInfo.deptName}
			</td>
			<td>
					${userInfo.userInfocq}
			</td>
			<td>
					${userInfo.userInfozc}
			</td>
			<td>
					${userInfo.userInfocd}
			</td>
			<td>
					${userInfo.userInfokg}
			</td>
			<td>
					${userInfo.userInfozt}
			</td>
			<td>
					${userInfo.userInfoqk}
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
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
</body>
</html>