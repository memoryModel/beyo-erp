<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学员信息</title>
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
<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classPlan/list">开班计划列表</a></li>
		<li class="active"><a href="${ctx}/school/classPlan/info?id=${student.schoolClassStudents.schoolClass.id}">开班计划详情</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classPlan/info?id=${student.schoolClassStudents.schoolClass.id}">基本信息</a></li>
		<li class="active"><a href="${ctx}/school/classPlan/classStudentInfo?id=${student.schoolClassStudents.schoolClass.id}">班级学员</a></li>
		<li><a href="${ctx}/school/classPlan/classInstall?id=${student.schoolClassStudents.schoolClass.id}">班级设置</a></li>
	</ul></div><br/>

	<form:form id="searchForm" modelAttribute="student" action="${ctx}/school/classPlan/classStudentInfo" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li hidden="hidden"><label>班级：</label>
				<form:input path="schoolClassStudents.schoolClass.id" value="${student.schoolClassStudents.schoolClass.id}" htmlEscape="false" maxlength="20" readonly="true" class="input-medium"/>
			</li>

			<li><label>学员姓名：</label>
				<form:input path="name" placeholder="请输入学员姓名/编号" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<%--<th><input type="checkbox"></th>--%>
			<th>学员姓名</th>
			<th>学号</th>
			<th>性别</th>
			<th>入班日期</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpStudentEnroll">
			<tr>
				<%--<td>
						<input type="checkbox" name="empid" value="${erpStudentEnroll.id}">${erpStudentEnroll.id}
				</td>--%>
				<td>
						${erpStudentEnroll.name}
				</td>
				<td>
						${erpStudentEnroll.studentNumber}
				</td>
				<td>
						${erp:sexStatusName(erpStudentEnroll.sex)}
				</td>
				<td>
						<fmt:formatDate value="${erpStudentEnroll.schoolClassStudents.applyTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						<input name="selectClass" classId="${erpStudentEnroll.schoolClassStudents.schoolClass.id}" studentId="${erpStudentEnroll.id}"  class="btn btn-primary" type="button" value="转班"/>
						<input name="quitClass" classId="${erpStudentEnroll.schoolClassStudents.schoolClass.id}"  studentId="${erpStudentEnroll.id}" class="btn btn-primary" type="button" value="退班"/>
						<%--<a href="${ctx}/erpstudentenroll/erpStudentInfo/info?id=${erpStudentEnroll.id}">转班</a>--%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<script type="text/javascript">
        var jbox;
		$(document).find("input[name='selectClass']").each(function () {
			var classId = $(this).attr("classId");
			var studentId = $(this).attr("studentId");
			$(this).click(function () {
				top.$.jBox.open("iframe:/school/studentInfo/selectClass?flag=1&&currentClassId="+classId+"&&erpStudentEnrollId="+studentId,
					"转班",
					1024,
					768
				);
			});
		});

        $(document).find("input[name='quitClass']").each(function () {
            var classId = $(this).attr("classId");
            var studentId = $(this).attr("studentId");
            $(this).click(function () {
                location.href = "${ctx}/school/classStudents/quitList?classId="+classId+"&&studentId="+studentId+"&&tagFlag=0";
            });
        });

        function selectClassCallback(erpStudentEnrollId,currentClassId,classId,className) {
            aa(erpStudentEnrollId,classId,currentClassId);
            console.info("newClassId:"+classId+"newClassName:"+className+"erpStudentEnrollId:"+erpStudentEnrollId+"currentClassId:"+currentClassId);
        }
        function aa(erpStudentEnrollId,classId,currentClassId){
            $.ajax({
                url:"${ctx}/school/studentInfo/changeClass",
                data:{"classId":classId,"erpStudentEnrollId":erpStudentEnrollId,"currentClassId":currentClassId},
                async:false,
                dataType:"json",
                success : function(data) {
                    if (data && data.result == "success") {
                        location.href = '${ctx}/school/classPlan/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }
	</script>
</body>
</html>