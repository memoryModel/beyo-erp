<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<body>
<script type="text/javascript">
    $(document).ready(function() {

    });

    function page(n,s){
        $("#pageNo").val(n);
        $("#pageSize").val(s);
        $("#searchForm").submit();
        return false;
    }

    function selectStudent(id,stuId,name,studentNumber,sex,phone,className,lessonName,teacherName,tuitionAmount,paymentType,tuitionFavorable,realBeginTime,applyTime,subjectName,lessonTypeName){
        console.log("#btnSelect"+lessonName+"--"+name+"--"+tuitionAmount+"--"+paymentType+"--"+tuitionFavorable+"--"+realBeginTime+"--"+applyTime+"--"+subjectName);
        top.$.jBox.confirm('确认要选择添加该学生吗？','系统提示',function(v,h,f) {
            if (v == 'ok') {
                parent.window.frames["mainFrame"].selectStudentback(id,stuId,name,studentNumber,sex,phone,className,lessonName,teacherName,tuitionAmount,paymentType,tuitionFavorable,realBeginTime,applyTime,subjectName,lessonTypeName);
                top.$.jBox.close(true);
            }
        },{buttonsFocus:1, closed:function(){
            if (typeof closed == 'function') {
                closed();
            }
        }});
    }

</script>
<table id="scheduleTable" class="table table-striped table-bordered table-condensed">
</table>

<ul class="nav nav-tabs">
</ul>
<form:form id="searchForm" modelAttribute="classStudents" action="${ctx}/school/classStudents/selectStudent" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<br class="ul-form">
		<li><label>姓名：</label>
			<form:input  path="student.name" htmlEscape="false" type="text" style="height:28px;width:200px;font-size:15px;" maxlength="20" class="input-medium"/>
		</li>
		<li><label>班级名称：</label>
			<form:input path="schoolClass.className" htmlEscape="false" type="text" style="height:28px;width:200px;font-size:15px;" maxlength="20" class="input-medium"/>
		</li>
		</br></br>
		<li><label>学号：</label>
			<form:input  path="student.studentNumber" htmlEscape="false" type="text" style="height:28px;width:200px;font-size:15px;" maxlength="20" class="input-medium"/>
		</li>
		<li><label>性别：</label>
			<form:select path="student.sex" class="input-large">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>&nbsp;&nbsp;&nbsp;&nbsp;
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
		<th>姓名</th>
		<th>班级</th>
		<th>学号</th>
		<th>性别</th>
		<th>手机号</th>
		<th>身份证号</th>
		<th>学员状态</th>
		<th>操作</th>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="classStudents">
		<tr>
			<td>
					${classStudents.student.name}
			</td>
			<td>
					${classStudents.schoolClass.className}
			</td>
			<td>
					${classStudents.student.studentNumber}
			</td>
			<td>
					${erp:sexStatusName(classStudents.student.sex)}
			</td>
			<td>
					${classStudents.student.phone}
			</td>
			<td>
					${classStudents.student.stuNumber}
			</td>
			<td>
					${erp:ClassStudentsName(classStudents.status)}
			</td>
			<td>

				<a id="btnSelect" class="btn btn-danger" onclick="selectStudent('${classStudents.id}','${classStudents.student.id}','${classStudents.student.name}','${classStudents.student.studentNumber}',
						'${erp:sexStatusName(classStudents.student.sex)}','${classStudents.student.phone}','${classStudents.schoolClass.className}',
						'${classStudents.schoolClass.schoolClassToLesson.schoolClassLesson.lessonName}','${classStudents.schoolClass.headteacher.name}',
						'${classStudents.schoolClass.tuitionAmount}','${erp:getCommonsTypeName(classStudents.order.payType)}','${classStudents.order.favorableAmount}','${classStudents.schoolClass.realBeginTime}',
						'${classStudents.applyTime}','${classStudents.schoolClass.schoolClassToLesson.schoolClassLesson.schoolSubject.subjectName}',
						'${classStudents.schoolClass.schoolClassToLesson.schoolClassLesson.schoolLessonType.lessonName}')"
				   href="javascript:; ">退班</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>