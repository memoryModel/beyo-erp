<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#asProCategoryButton").addClass("disabled");
			//$("#userButton").addClass("disabled");
			
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<div>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/school/classPlan/list">开班计划列表</a></li>
		<li class="active"><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">开班计划详情</a></li>
	</ul></div><br/><div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/school/classPlan/info?id=${schoolClass.id}">基本信息</a></li>
		<li><a href="${ctx}/school/classPlan/classStudentInfo?id=${schoolClass.id}">班级学员</a></li>
		<li><a href="${ctx}/school/classPlan/classInstall?id=${schoolClass.id}">班级设置</a></li>
	</ul></div><br/>
	
	<form:form id="inputForm" modelAttribute="schoolClass" class="form-horizontal">
		<form:hidden path="id"/>
		<table id="contentTable">
			<tr>
				<td >
					<div class="control-group">
						<label class="control-label">班级名称:</label>
						<div class="controls">
							<input value="${schoolClass.className}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">班型：</label>
						<div class="controls">
							<form:select path="classType" class="required input-medium" disabled="true">
								<form:option value="" label="--请选择--"/>
								<form:options items="${erp:getCommonsTypeList(50)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">最大招收学员:</label>
						<div class="controls">
							<input value="${schoolClass.classMaxNum}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">班级预计招收人数:</label>
						<div class="controls">
							<input value="${schoolClass.classMinNum}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">实际招收学员:</label>
						<div class="controls">
							<input value="${schoolClass.classRealNum}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">计划开班日期:</label>
						<div class="controls">
							<input id="planBeginTime" name="planBeginTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${schoolClass.planBeginTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">计划结业日期:</label>
						<div class="controls">
							<input id="planEndTime" name="planEndTime" style="width:250px;" type="text" readonly="readonly"
								   value="<fmt:formatDate value="${schoolClass.planEndTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
			</tr>


			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">班级状态:</label>
						<div class="controls">
							<input value="${erp:classPlanStatusName(schoolClass.status)}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">课时数目:</label>
						<div class="controls">
							<input value="${schoolClass.classTime}" type="text" readonly="readonly" style="width:250px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">学费:</label>
						<div class="controls">
							<table id="billsTable" class="table table-striped table-bordered table-condensed" style="width: 78%;">
								<tr>
									<td colspan="2">
										预付金:
										<form:input path="prepaidAmount" value="${schoolClass.prepaidAmount}元" disabled="true" style="width:80px;"/>
									</td>
									<td colspan="2">
										学费:
										<form:input path="tuitionAmount" value="${schoolClass.tuitionAmount}元" disabled="true" style="width:80px;"/>
									</td>
									<td colspan="2">
										学杂费:
										<form:input path="miscellaneousAmount" value="${schoolClass.miscellaneousAmount}元" disabled="true" style="width:80px;"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">备注:</label>
						<div class="controls">
							<form:textarea path="remark"  rows="4" disabled= "true" style="width:709px;"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
		
		
		
	</form:form>
</body>
</html>