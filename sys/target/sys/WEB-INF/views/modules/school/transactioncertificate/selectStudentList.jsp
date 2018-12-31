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

    function selectStudent(id,name,studentNumber,sex,phone,className,studentId,classId){
        top.$.jBox.confirm('确认要选择添加该学生吗？','系统提示',function(v,h,f) {
            if (v == 'ok') {
                var transactionCertificateJsonArray = ${fns:toJson(transactionCertificateList)};
                parent.window.frames["mainFrame"].selectStudentback(id,name,studentNumber,sex,phone,className,studentId,classId,transactionCertificateJsonArray);
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
<form:form id="searchForm" modelAttribute="classStudents" action="${ctx}/school/transactionCertificate/selectStudent" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">

		<li><label>班级名称：</label>
			<form:input type="text" path="schoolClass.className" style="height:28px;width:200px;font-size:15px;" maxlength="20" class="input-medium"  />
		</li>

		<li><label>学生姓名：</label>
			<form:input type="text" path="student.name" style="height:28px;width:210px;font-size:15px;" maxlength="20" class="input-medium"  />
		</li>
		<li><label>学号：</label>
			<form:input type="text" path="student.studentNumber" style="height:28px;width:200px;font-size:15px;" maxlength="20" class="input-medium"  />
		</li><br>
		<li><label>性别：</label>
			<form:select path="student.sex" class="input-large ">
				<form:option value="">请选择</form:option>
				<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>姓名</th>
		<th>班级名称</th>
		<th>学号</th>
		<th>性别</th>
		<th>手机号</th>
		<th>身份证号</th>
		<th>学生状态</th>
		<th>操作</th>
	</tr>
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
				<a id="btnSelect" class="btn btn-primary" onclick="selectStudent('${classStudents.id}','${classStudents.student.name}','${classStudents.student.studentNumber}','${erp:sexStatusName(classStudents.student.sex)}',
						'${classStudents.student.phone}','${classStudents.schoolClass.className}','${classStudents.student.id}','${classStudents.schoolClass.id}')"
				   href="javascript:; ">办理证书</a>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>