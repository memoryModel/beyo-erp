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
<br>
	<ul class="nav nav-tabs">
		<li ><a href="${ctx}/school/student/info?id=${student.id}&&tagFlag=${tagFlag}">基本信息</a></li>
		<c:if test="${tagFlag != 1 }">
			<li><a href="${ctx}/school/student/enrollInfo?id=${student.id}&&tagFlag=${tagFlag}">招生信息</a></li>
			<li ><a href="${ctx}/school/student/classInfo?id=${student.id}&&tagFlag=${tagFlag}">报读班级</a></li>
			<li><a href="${ctx}/school/student/scheduleInfo?id=${student.id}&&tagFlag=${tagFlag}">课表信息</a></li>
			<li><a href="${ctx}/school/student/signInfo?id=${student.id}&&tagFlag=${tagFlag}">上课记录</a></li>
		</c:if>
		<li class="active"><a href="${ctx}/school/student/communicateInfo?id=${student.id}&&tagFlag=${tagFlag}">沟通记录</a></li>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<th>沟通时间</th>
		<th>跟进人</th>
		<th>沟通类型</th>
		<th>下次跟进类型</th>
		<th>下次跟进日期</th>
		<th>沟通内容</th>
		</thead>
		<tbody>
		<c:forEach items="${communicationList}" var="communication">
			<tr>
				<td><fmt:formatDate value="${communication.createTime}" pattern="yyyy-MM-dd"/></td>
				<td>${communication.user.name}</td>
				<td>${erp:getCommonsTypeName(communication.commonsTypeId)}</td>
				<td>${erp:getCommonsTypeName(communication.nextType)}</td>
				<td><fmt:formatDate value="${communication.nextTime}" pattern="yyyy-MM-dd"/></td>
				<td>${communication.content}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>