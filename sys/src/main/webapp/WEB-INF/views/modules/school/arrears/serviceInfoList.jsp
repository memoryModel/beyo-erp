<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>欠费管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/erp/arrears/list">欠费列表</a></li>
</ul>
<ul class="nav nav-tabs">
	<li ><a href="${ctx}/erp/arrears/info?id=${receivableBill.id}&&orderId=${receivableBill.order.id}">基本信息</a></li>
	<li  class="active"><a href="${ctx}/erp/arrears/serviceInfo?id=${receivableBill.id}&&orderType=${receivableBill.order.orderType}&&orderId=${receivableBill.order.id}">订单信息</a></li>
	<li><a href="${ctx}/erp/arrears/receivableAmountInfo?orderId=${receivableBill.order.id}&&id=${receivableBill.id}">收款信息</a></li>
	<%--<li><a href="${ctx}/erp/arrears/expendAmountInfo?id=${receivableBill.id}&&orderId=${receivableBill.order.id}">支出信息</a></li>--%>
</ul><br/>
<form:form id="inputForm" modelAttribute="receivableBill" action="${ctx}/erp/arrears/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<c:if test="${orderType ==2}">
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>服务人员</th>
				<th>服务内容</th>
				<th>入户时间</th>
				<th>下户时间</th>
				<th>服务状态</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${dispatchList}" var="dispatch">
				<tr>
					<td>
							${dispatch.orderItem.productSku.skill.skillName}
					</td>
					<td>
							${dispatch.orderItem.productSku.skill.skillName}
					</td>
					<td>
						    <fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						    <fmt:formatDate value="${dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
							${erp:dispatchStatusName(dispatchList.status)}
					</td>
				</tr>
			 </c:forEach>
			</tbody>
		</table>
	</c:if>
	<c:if test="${orderType ==1}">
		<table>

			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">班级名称：</label>
						<div class="controls">
							<input value="${receivableBill.order.student.schoolClassStudents.schoolClass.className}" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">状态：</label>
						<div class="controls">
							<input value="${erp:classStatusName(receivableBill.order.student.schoolClassStudents.schoolClass.status)}" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">课程：</label>
						<div class="controls">
						    <input value="${receivableBill.lessonName}" type="text" readonly="readonly" style="width:600px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">班主任：</label>
						<div class="controls">
						    <input value="${receivableBill.order.student.schoolClassStudents.schoolClass.headteacher.name}" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
				<td>
					<div>
						<label class="control-label">招生人数：</label>
						<div class="controls">
							<input value="${receivableBill.order.student.schoolClassStudents.schoolClass.classRealNum}" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">开班日期：</label>
						<div class="controls">
							<input value="<fmt:formatDate value="${receivableBill.order.student.schoolClassStudents.schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
				<td>
					<div>
						<label class="control-label">结业日期：</label>
						<div class="controls">
							<input value="<fmt:formatDate value="${receivableBill.order.student.schoolClassStudents.schoolClass.realEndTime}" pattern="yyyy-MM-dd"/>" type="text" readonly="readonly" style="width:200px;"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</c:if>
</form:form>
</body>
</html>