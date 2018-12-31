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


        function selectStudent(studentId,name,studentNumber,phone,userName,userPhone,nativePlaces){
            console.log("#btnSelect"+studentId,studentNumber,phone,userName,userPhone,nativePlaces);
            top.$.jBox.confirm('确认要选择添加该学员吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectStudentCallback(studentId,name,studentNumber,phone,userName,userPhone,nativePlaces);
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
	<form:form id="searchForm" modelAttribute="student" action="${ctx}/erp/dormStudentLive/selectStudent" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>招聘老师：</label>
				<form:input path="teacher.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>跟进人：</label>
				<form:input path="follow.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>学员类型：</label>
				<form:select path="studentType" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:StudentTypeList()}"  itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>职业方向：</label>
				<form:select path="occupationId" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
				</form:select>
			</li><br/><br/>
			<li><label>创建时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>



	</form:form>
	<sys:message content="${message}"/>

	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>

			<th>学生姓名</th>
			<th>学生性别</th>
			<th>学号</th>
			<th>手机号码</th>
			<th>招生来源</th>
			<th>学员类型</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		</thead>
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
						${student.studentNumber}
				</td>
				<td>
						${student.phone}
				</td>
				<td>
						${student.customerResource.customerName}<%--招生来源--%>
				</td>
				<td>
						${erp:studentTypeName(student.studentType)}<%--学员类型--%>
				</td>
				<td>
						${erp:studentStatusName(student.status)}
				</td>
				<td>
					<fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--创建时间--%>
				</td>
				<td>
					<shiro:hasPermission name="erp:dormStudentLive:selectStudent"><a id="btnSelect" class="btn btn-primary" onclick="selectStudent('${student.id}','${student.name}','${student.studentNumber}','${student.phone}','${student.schoolClassStudents.schoolClass.headteacher.name}','${student.schoolClassStudents.schoolClass.headteacher.phone}','${student.nativePlace.name}')"
					   href="javascript:; ">添加学员</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>