<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
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
            //选择客户表
            $("#selectcustomer").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/select", "客户表", 1024, 520);<!--跳转到controller-->
            });
            //选择员工表
            $("#selectEmployee").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/selectEmployee", "员工表", 1024, 520);<!--跳转到controller-->
            });
            $("#selectUser").click(function () {
                studentJbox =  top.$.jBox.open("iframe:/crm/customer/selectUser", "服务人员表", 1024, 520);<!--跳转到controller-->
            });

            jQuery.validator.addMethod("phoneExist", function(value, element) {

                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/crm/customer/isExist",
                    data:"graphone="+value,
                    success: function(data){
                        console.log(data);
                        if(data=="success"){
                            flag = true;
                        }else{
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "手机号码已存在");

		});

        function selectCustomerCallback(id,names){
            $("#empId").val(id);
            $("#employeeName").val(names);
        }
        function selectEmployeeCallback(id,name){
            $("#empId").val(id);
            $("#employeeName").val(name);
        }
        function selectUserCallback(id,name){
            $("#empId").val(id);
            $("#employeeName").val(name);
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">

			<li class="active"><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<%--<a href="#">扩展信息</a></li>
			<a href="#">联系信息</a></li>--%>
			<li><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
			<li><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
			<li><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
			<li><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
			<li><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
		<li><a href="">服务记录</a></li>

	</ul><br/>
	<form:form id="inputForm" modelAttribute="customer" action="${ctx}/crm/customer/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户编号：</label>
						<div class="controls">
							<form:input path="code" htmlEscape="false" maxlength="200" readonly="true" class="required input-xlarge " style="width:208px"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
				<div class="control-group">
					<label class="control-label">客户姓名：</label>
					<div class="controls">
						<form:input path="name" htmlEscape="false" maxlength="200" readonly="true" class="required input-xlarge " style="width:208px"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户性别：</label>
						<div class="controls">
							<form:input path="sex" htmlEscape="false" maxlength="50" readonly="true" value="${erp:sexStatusName(customer.sex)}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20"  style="width:210pxpx;"
								   value="<fmt:formatDate value="${customer.birthTime}" pattern="yyyy-MM-dd"/>"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">QQ号码：</label>
						<div class="controls">
							<form:input path="qqCode" htmlEscape="false" readonly="true" maxlength="50" class="qq valid"/>
						</div>
					</div>
				</td>

				<td>
					<div class="control-group">
						<label class="control-label">邮箱地址：</label>
						<div class="controls">
							<form:input path="email" readonly="true" htmlEscape="false" maxlength="128" class="email valid "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<%--<td>
					<div class="control-group">
						<label class="control-label">成单状态：</label>
						<div class="controls">
							<form:input path="status" htmlEscape="false" maxlength="50" readonly="true" value="${erp:changeStatusName(customer.status)}"/>
						</div>
					</div>
				</td>--%>
				<td>
				<div class="control-group">
					<label class="control-label">手机号码：</label>
					<div class="controls">
						<form:input path="phone"  id="phone"  htmlEscape="false" maxlength="50" readonly="true"/>
						<span id="grade"></span>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">地区：</label>
						<div class="controls">
							<form:input path="area" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${customer.area.name}"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">来源：</label>
						<div class="controls">
							<form:input path="customerResource" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${customer.customerResource.customerName}"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户类型：</label>
						<div class="controls">
							<form:input path="type" htmlEscape="false" maxlength="50" readonly="true" value="${erp:customerStatusName(customer.type)}"/>
						</div>
					</div>
				</td>

				<td colspan="2">
					<div class="control-group">
						<label class="control-label">推荐人：</label>

						<div class="controls">
							<c:if test="${employee.id == null || employee.recommendId == null}">
								<input  type="text"   id="recommendName"
										style="width:200px;" readonly="readonly" />&nbsp;&nbsp;
							</c:if>
							<c:if test="${employee.id != null }">
								<c:if test="${employee.tableType == 1}">
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${employee.customer.name}"/>&nbsp;&nbsp;
								</c:if>
								<c:if test="${employee.tableType == 2}">
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${employee.user.name}"/>&nbsp;&nbsp;
								</c:if>
								<c:if test="${employee.tableType == 3}">
									<%-- <form:input path="" htmlEscape="false" maxlength="50" class="input-large" readonly="true" value="${recommonedName}"/>--%>
									<input  type="text"   id="recommendName"
											style="width:200px;" readonly="readonly" value="${recommendNames}"/>&nbsp;&nbsp;
								</c:if>
							</c:if>
							<%--<input id="selectCustomer" class="btn btn-primary" type="button" value="从客户中选择"/>
							<input id="selectUser" class="btn btn-primary" type="button" value="从员工中选择"/>
							<input id="selectServicePeople" class="btn btn-primary" type="button" value="从服务人员中选择"/>--%>
						</div>

					</div>
				</td>

			</tr>
			<tr>
				<td colspan="2">
				<div class="control-group">
					<label class="control-label">详情地址：</label>
					<div class="controls">
						<form:textarea path="address" htmlEscape="false" rows="4" maxlength="200" class="required input-xxlarge " style="width: 635px;" readonly="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</div>
				</td>
			</tr>
		</table>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>