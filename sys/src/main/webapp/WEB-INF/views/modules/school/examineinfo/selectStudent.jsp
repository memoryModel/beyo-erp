<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>单表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        var currentstudentId = "${classStudentId}";
        var classStudentJson = "${classStudentJson}";
        var studentDataArray = new Array();

        $(document).ready(function() {
            if(classStudentJson && classStudentJson!="undefined"){
                classStudentJson = JSON.parse(decodeURIComponent(classStudentJson));
                console.log(classStudentJson);
                if (classStudentJson && classStudentJson.length>0){
                    studentDataArray = classStudentJson;
				}

			}

			$("input[name='selectStudent']").each(function () {

			    for(var i=0;i<studentDataArray.length;i++){
                    if($(this).attr("studentId") == studentDataArray[i].studentId && $(this).attr("classId") == studentDataArray[i].classId){
                        $(this).attr("checked","checked");
                        return;
					}
				}

            });
        });

        function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }


        function selectEnroll(checkbox,classId,className,studentId,studentName,studentNumber){

            var chked = $(checkbox).attr("checked");

            parent.window.frames["mainFrame"].selectStudentCallback(classId,className,studentId,studentName,studentNumber,chked);
        }
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="classStudents" action="/school/examineInfo/selectStudent" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input type="hidden" name="classStudentJson" value="${classStudentJson}">
		<input type="hidden" name="examStatus" value="${classStudents.examStatus}">
		<input type="hidden" name="lessonId" value="${classStudents.lessonId}"/>
		<ul class="ul-form">
			<li>
				<label>学员姓名：</label>
				<form:input path="student.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>学员手机：</label>
				<form:input path="student.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>报读班级：</label>
				<form:input path="schoolClass.className" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="clearfix"></li>
			<li><label>报名时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${classStudents.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${classStudents.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th></th>
				<th>学号</th>
				<th>学员姓名</th>
				<th>学生性别</th>
				<th>手机号码</th>
				<th>班级</th>
				<th>职业方向</th>
				<th>招生来源</th>
				<th>招聘老师</th>
				<th>跟进人</th>
				<th>学员类型</th>
				<th>报名时间</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="classStudent">
			<tr>
				<td>
					<input name="selectStudent" type="checkbox" studentId="${classStudent.student.id}" classId="${classStudent.schoolClass.id}" onchange="selectEnroll(this,'${classStudent.schoolClass.id}','${classStudent.schoolClass.className}',
							'${classStudent.student.id}','${classStudent.student.name}','${classStudent.student.studentNumber}')"/>
				</td>
				<td>
						${classStudent.student.studentNumber}
				</td>
				<td>
					${classStudent.student.name}
				</td>

				<td>
					${erp:sexStatusName(classStudent.student.sex)}
				</td>
				<td>
					${classStudent.student.phone}
				</td>
				<td>
						${classStudent.schoolClass.className}
				</td>
				<td>
					<c:forEach items="${classStudent.student.getOccupationList()}" var="occId">
						${erp:getCommonsTypeName(occId)}
					</c:forEach>
				</td>
				<td>
					${classStudent.student.customerResource.customerName}<%--招生来源--%>
				</td>
				<td>
					${classStudent.student.teacher.name}<%--招聘老师--%>
				</td>
				<td>
					${classStudent.student.follow.name}<%--跟进人--%>
				</td>
				<td>
					${erp:studentTypeName(classStudent.student.studentType)}
				</td>
				<td>
					<fmt:formatDate value="${classStudent.student.createTime}" pattern="yyyy-MM-dd"/><%--创建时间--%>
				</td>
				<td>
					${erp:studentStatusName(classStudent.student.status)}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>