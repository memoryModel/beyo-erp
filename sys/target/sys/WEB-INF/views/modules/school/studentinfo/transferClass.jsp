<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>转班</title>
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

        var jbox;
        function selectClassCallback(erpStudentEnrollId,currentClassId,classId,className) {
            aa(erpStudentEnrollId,classId,currentClassId);
            $("#newClassName").html(className);
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
                        location.href = '${ctx}/school/studentInfo/list/';
                    } else {
                        window.location.reload();
                    }
                }
            })
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/school/studentInfo/info?id=${student.id}"><font size="3">转班</font></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="student" action="${ctx}/school/studentInfo/info" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" value="${student.schoolClassStudents.schoolClass.id}" id="ClassId">


	<table id="contentTable" class="table table-striped table-bordered table-condensed" align="center" style="width:90%;font-size:16px;">

		<thead>
		<br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label class="control-label"><font size="4">${student.name},&nbsp;&nbsp;&nbsp;当前报读班级:</font></label>
		<br/><br/>
				<%--<th>classId</th>--%>
				<th>入班日期</th>
				<th>班级名称</th>
				<th>课程</th>
				<th>学费</th>
				<th>班主任</th>
				<th>班级状态</th>
				<th>学生状态</th>
				<th>操作</th>

		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="student">
					<tr>
						<%--<td>${student.schoolClassStudents.schoolClass.id}</td>--%>
						<td><fmt:formatDate value="${student.schoolClassStudents.schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/></td>
						<td>${student.schoolClassStudents.schoolClass.className}</td>
						<td>${student.schoolClassStudents.schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}</td>
						<td>${student.schoolClassStudents.schoolClass.tuitionAmount}</td>
						<td>${student.schoolClassStudents.schoolClass.headteacher.name}</td>
						<td>${erp:classStatusName(student.schoolClassStudents.schoolClass.status)}${erp:classPlanStatusName(student.schoolClassStudents.schoolClass.status)}</td>
						<td>${erp:ClassStudentsName(student.schoolClassStudents.status)}</td>
						<td>
						<c:if test="${student.schoolClassStudents.status == 4 || student.schoolClassStudents.status == 0}">
							<shiro:hasPermission name="school:studentInfo:selectClass"><input name="selectClass" classId="${student.schoolClassStudents.schoolClass.id}"  class="btn btn-primary" type="button" value="转班"/></shiro:hasPermission>

						</c:if>

						</td>
					</tr>
			</c:forEach>
		</tbody>
	</table>

	<input type="hidden" value="${student.id}" id="erpStudentEnrollId">
	</form:form>
	<sys:message content="${message}"/>
	<be/>
	<script type="text/javascript">
        $(document).find("input[name='selectClass']").each(function () {
            var classId = $(this).attr("classId");
            //alert(classId);
            $(this).click(function () {
                top.$.jBox("iframe:/school/studentInfo/selectClass?currentClassId="+classId+"&&erpStudentEnrollId="+$("#erpStudentEnrollId").val(), {
                    title:"转班",
                    width:700,
                    height:550,
                    buttons:{}
                });
            });
        });

	</script>
</body>
</html>