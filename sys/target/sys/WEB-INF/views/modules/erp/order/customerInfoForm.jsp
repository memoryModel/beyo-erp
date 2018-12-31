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
        function selectEmployeeCallback(id,names){
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
	<li  class="active"><a href="${ctx}/erp/allOrder/list">全部订单列表</a></li>
</ul><br/>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/erp/allOrder/form?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">订单信息</a></li>
	<li  class="active"><a href="${ctx}/erp/allOrder/customerInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">
		<c:if test="${order.orderType == 1}">
		    学生信息
	    </c:if>
		<c:if test="${order.orderType == 2}">
			客户信息
		</c:if>
	</a></li>
	<li><a href="${ctx}/erp/allOrder/contractInfo?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">合同信息</a></li>
	<li><a href="${ctx}/erp/allOrder/form?id=${order.id}&&studentId=${order.student.id}&&tagFlag=${tagFlag}">结算信息</a></li>
	<%--<li><a href="${ctx}/erp/allOrder/form?id=${order.id}">服务信息</a></li>--%>
</ul>
	<form:form id="inputForm" modelAttribute="order" action="${ctx}/erp/allOrder/customerInfo" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<c:if test="${order.orderType == 1}">
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">名称：</label>
							<div class="controls">
								<form:input path="student.name"  htmlEscape="false" class="required input-xlarge"  maxlength="64" style="width: 210px" value="${order.student.name}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">身份证号：</label>
							<div class="controls">
								<form:input path="student.stuNumber" htmlEscape="false"  class="card valid" style="width: 210px" value="${order.student.stuNumber}" readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">出生日期：</label>
							<div class="controls">
								<input  name="student.dateBirth" type="text" readonly="readonly" style="width: 210px" class="required input-medium Wdate " readonly="true"
										value="<fmt:formatDate value="${order.student.dateBirth}" pattern="yyyy-MM-dd"/>"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">手机号码：</label>
							<div class="controls">
								<form:input path="student.phone" htmlEscape="false"  class="required mobile valid" style="width: 210px" value="${order.student.phone}"  readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>

					<td>
						<div class="control-group">
							<label class="control-label">紧急联系人：</label>
							<div class="controls">
								<form:input path="student.emergencyContact" htmlEscape="false"  class="required input-xlarge" style="width: 210px" value="${order.student.emergencyContact}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">QQ号码：</label>
							<div class="controls">
								<form:input path="student.qqNumber" htmlEscape="false"  class="qq valid" style="width: 210px" value="${order.student.qqNumber}"  readonly="true"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">紧急联络人电话：</label>
							<div class="controls">
								<form:input path="student.urgencyPhone" htmlEscape="false"  class="required simplePhone valid " style="width: 210px"  value="${order.student.urgencyPhone}"  readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>

					<td>
						<div class="control-group">
							<label class="control-label">性别：</label>
							<div class="controls">
								<form:input path="student.sex" htmlEscape="false"  class="required input-xlarge" style="width: 210px"  value="${erp:sexStatusName(order.student.sex)}"  readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">籍贯:</label>
							<div class="controls">
								<form:input path="student.nativePlace.id" htmlEscape="false"  class="required input-xlarge" style="width: 210px"  value="${order.student.nativePlace.name}"  readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">学员类型：</label>
							<div class="controls">
								<form:input path="student.studentType" htmlEscape="false"  class="required input-xlarge" style="width: 210px"  value="${erp:studentTypeName(order.student.studentType)}"  readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
			</c:if>
			<c:if test="${order.orderType == 2}">
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">客户姓名：</label>
							<div class="controls">
								<form:input path="customer.name" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:210px" value="${order.customer.name}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">客户性别：</label>
							<div class="controls">
								<form:input path="customer.sex" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:210px" value="${erp:sexStatusName(order.customer.sex)}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">员工出生日期：</label>
							<div class="controls">
								<input name="customer.birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate " style="width:210px"
									   value="<fmt:formatDate value="${order.customer.birthTime}" pattern="yyyy-MM-dd"/>"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">客户类型：</label>
							<div class="controls">
								<form:input path="customer.type" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:210px" value="${erp:customerStatusName(order.customer.type)}" readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">邮箱地址：</label>
							<div class="controls">
								<form:input path="customer.email" htmlEscape="false" maxlength="200" class="required input-xlarge " style="width:210px" value="${order.customer.email}" readonly="true"/>

							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">手机号码：</label>
							<div class="controls">
								<form:input path="customer.phone" htmlEscape="false" maxlength="50" class="required mobile phoneExist valid" value="${order.customer.phone}" readonly="true" style="width:210px"/>
								<span id="grade"></span>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">QQ号码：</label>
							<div class="controls">
								<form:input path="customer.qqCode" htmlEscape="false" maxlength="50" class="qq valid" value="${order.customer.qq}" readonly="true" style="width:210px"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>

					<td>
						<div class="control-group">
							<label class="control-label">地区：</label>
							<div class="controls">
								<form:input path="customer.area.id" htmlEscape="false" maxlength="50" class="qq valid" value="${order.customer.area.name}" readonly="true" style="width:210px"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">客户来源：</label>
							<div class="controls">
								<form:input path="customer.customerResource.id" htmlEscape="false" maxlength="50" class="qq valid" value="${order.customer.customerResource.customerName}" readonly="true" style="width:210px"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<!--从员工中选择-->
						<div class="control-group">
							<label class="control-label">推荐人员：</label>
							<div class="controls">
								<form:input path="customer.recommendUser" htmlEscape="false" id="employeeName" maxlength="200" class="required input-xlarge " style="width:210px" value="${order.customer.recommendUser}" readonly="true"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">详情地址：</label>
							<div class="controls">
								<form:textarea path="customer.address" htmlEscape="false" rows="4" maxlength="200" class="required input-xxlarge " style="width: 700px;" value="${order.customer.address}" readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
			</c:if>

		</table>
	</form:form>
</body>
</html>