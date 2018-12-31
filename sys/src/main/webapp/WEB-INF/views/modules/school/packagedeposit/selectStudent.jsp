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


        function selectStudent(studentId,name,phone,stuNumber){
            console.log("#btnSelect"+studentId,name,phone,stuNumber);
            top.$.jBox.confirm('确认要选择添加该学员吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectEnrollCallback(studentId,name,phone,stuNumber);
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
	<form:form id="searchForm" modelAttribute="student" action="${ctx}/erp/packageDeposit/selectEnroll" method="post" class="breadcrumb form-search">
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
					   value="<fmt:formatDate value="${student.createTimeStart}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${student.createTimeEnd}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>

			<li><label>客户状态：</label>
				<form:select path="communication.status" class="input-large ">
					<form:option value="">请选择</form:option>
					<form:options items="${erp:clientStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
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

			<th>学生姓名</th>
			<th>学生性别</th>
			<th>手机号码</th>
			<th>招生来源</th>
			<th>招聘老师</th>
			<th>创建时间</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erpStudentEnroll">
			<tr>

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
						${erpStudentEnroll.customerResource.customerName}<%--招生来源--%>
				</td>
				<td>
						${erpStudentEnroll.teacher.name}<%--招聘老师--%>
				</td>
				<td>
					<fmt:formatDate value="${erpStudentEnroll.createTime}" pattern="yyyy-MM-dd HH:mm"/><%--创建时间--%>
				</td>
				<td>
					<shiro:hasPermission name="erp:packageDeposit:selectEnroll"><a id="btnSelect" class="btn btn-primary" onclick="selectStudent('${erpStudentEnroll.id}','${erpStudentEnroll.name}','${erpStudentEnroll.phone}','${erpStudentEnroll.stuNumber}')"
					   href="javascript:; ">添加学员</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>