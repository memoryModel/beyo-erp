<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工资结算管理</title>
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
            var currentTime = new Date();
            var confirmTime= currentTime.Format("yyyy-MM-dd hh:mm");
            $("#confirmTime").val(confirmTime);


            //保存增项
			$("[name='saveAmount'],[name='saveDownAmount']").click(function () {
                var element = $(this);
                var nameElement = $(this).parent().parent().find('[name="name"]');
                var amountElement = $(this).parent().parent().find('[name="amount"]');
                var categoryElement = $(this).parent().parent().find('[name="category"]');
                var name = $(nameElement).val();
                var amount = $(amountElement).val();
                var category = $(categoryElement).val();
                var totalAmountElement = $('input[name="totalAmount"]');
                if(category == 1){
                    var amountFloat = returnFloat(amount);
                    if((parseFloat(amountFloat)>parseFloat(totalAmountElement.val()))){
                        alert("输入金额大于支出金额");
                        return;
                    }
                }
                var amountHTML = $(this).parent().parent().clone(true);
                var amountHTMLJquery = $(amountHTML);
              	$('#hdAmoutHTML').html(amountHTMLJquery[0]);
                $.ajax({
					url:'${ctx}/crm/employeePayRecordItem/save',
                    async:false,
					data:{"name":name,"amount":amount,"category":category,"totalAmountStr":$(totalAmountElement).val()},

					type:"post",
					success:function(data){
					    alert(data);
						if(data != null){
						    $(totalAmountElement).val(data);
						    $(element).parent().remove();
						    $(nameElement).attr("disabled","disabled");
                            $(amountElement).attr("disabled","disabled");
                            $(categoryElement).attr("disabled","disabled");
						}
					}
				})
            })

			$('#hdAmoutHTML').hide();

		});
		/*增项添加*/
        function add(){
            var element = $("#table").find("tr:first");
            var amountHtml = $('#hdAmoutHTML').html();
            if(amountHtml == null || amountHtml == '' ||"undefined" == typeof amountHtml){
                $('#table').append($(element).clone(true));
			}else{
                $('#table').append(amountHtml);
                $('#table').find('tr:last').find('input[type="text"][name="name"]').val('');
                $('#table').find('tr:last').find('input[type="text"][name="amount"]').val('');
			}
        }
		/*增项的删除*/
        function del(btn) {
            var tr = btn.parentElement.parentElement;
            var tbl = tr.parentElement;
            if (tr.rowIndex >= 1) {
                tbl.deleteRow(tr.rowIndex);
            } else {

            }
        }

		/*减项添加*/
        function add1(){
            var element = $("#table").find("tr:first");
            var amountHtml = $('#hdAmoutHTML').html();
            if(amountHtml == null || amountHtml == '' ||"undefined" == typeof amountHtml){
                $('#table1').append($(element).clone(true));
            }else{
                $('#table1').append(amountHtml);
                $('#table1').find('tr:last').find('input[type="text"][name="name"]').val('');
                $('#table1').find('tr:last').find('input[type="text"][name="amount"]').val('');
            }
		}

		/*减项的删除*/
        function del1(btn) {
            var tr = btn.parentElement.parentElement;
            var tbl = tr.parentElement;
            if (tr.rowIndex >= 1) {
                tbl.deleteRow(tr.rowIndex);
            } else {

            }
        }

        function returnFloat(value){
            var value=Math.round(parseFloat(value)*100)/100;
            var xsd=value.toString().split(".");
            if(xsd.length==1){
                value=value.toString()+".00";
                return value;
            }if(xsd.length>1){
				if(xsd[1].length<2)
				{value=value.toString()+"0";

				}
                	return value;
            }
        }
	</script>

</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/employeepayrecord/list/">工资结算</a></li>
		<li class="active"><a href="${ctx}/crm/employeepayrecord/form?id=${employeePayRecord.id}">工资确认</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeePayRecord" action="${ctx}/crm/employeepayrecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info">服务人员信息</div>
		<div class="control-group">
			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">服务人员姓名：</label>
							<div class="controls">
								<form:input path="employee.name" htmlEscape="false" maxlength="20" readonly="true"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">服务人员工号：</label>
							<div class="controls">
								<form:input path="employee.code" htmlEscape="false" maxlength="20" readonly="true"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">手机号：</label>
							<div class="controls">
								<form:input path="employee.phone" htmlEscape="false" maxlength="20" readonly="true"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">员工性质：</label>
							<div class="controls">
								<form:select path="employee.type" class="input-large" disabled="true" >
									<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value"  htmlEscape="false"/>
								</form:select>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">工种：</label>
							<div class="controls">
								<form:select path="employee.profession" class="required input-large" disabled="true">
									<form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
								</form:select>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<div class="alert alert-info">应发工资</div>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;">
				<thead>
				<tr>
					<th>订单编号</th>
					<th>客户信息</th>
					<th>客户手机号</th>
					<th>服务项目</th>
					<th>数量/单位</th>
					<th>应发工资</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${dispatchEmployeeList}" var="dispatchEmployee">
					<tr>
						<td>
								${dispatchEmployee.dispatch.order.orderCode}
						</td>
						<td>
								${dispatchEmployee.dispatch.customer.name}
						</td>
						<td>
								${dispatchEmployee.dispatch.customer.phone}
						</td>
					  	<td>
						   		${dispatchEmployee.dispatch.skill.skillName}
					   	</td>
						<td>
								${dispatchEmployee.dispatch.orderItem.productSku.unit}
						</td>
						<td>
								${dispatchEmployee.dispatch.orderItem.productSku.servicePrice}
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="alert alert-info">其他项目</div>
		<h4>增项</h4>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;"  id="table">
				<tr>
					<input type="hidden" name="category" value="2">
					<td>
						*增项名称：
					</td>
					<td>
						<input type="text" name="name">
					</td>
					<td>
						*增项金额：
					</td>
					<td>
						<input type="text" name="amount">
					</td>
					<td>
						<a href="javascript:;" onclick="del(this);">删除</a>
					</td>
					<td>
						<input type="button" name="saveAmount" value="保存">
					</td>
				</tr>
			</table>
			<input id="selectItems" class="btn btn-primary" type="button" value="添加一项"  onclick="add()"/>
		</div>
		<h4>减项</h4>
		<div class="control-group">
			<table  class="table table-striped table-bordered table-condensed" style="width:90%;"  id="table1">
				<tr>
					<input type="hidden" name="category" value="1">
					<td>
						*减项名称：
					</td>
					<td>
						<input type="text" name="name">
					</td>
					<td>
						*减项金额：
					</td>
					<td>
						<input type="text" name="amount">
					</td>
					<td>
						<a href="javascript:;" onclick="del1(this);">删除</a>
					</td>
					<td>
						<input type="button" name="saveDownAmount" value="保存">
					</td>
				</tr>
			</table>
			<input id="selectItems1" class="btn btn-primary" type="button" value="添加一项"  onclick="add1()"/>
		</div>

		<div class="alert alert-info">工资结算</div>
		<div class="control-group">
			<table>
				<tr>
					<td>
						<%--<div class="control-group">
							<label class="control-label">财务科目：</label>
							<div class="controls">
								<form:input path="" htmlEscape="false" maxlength="20"/>
							</div>
						</div>--%>
					</td>
					<%--<td>
						<div class="control-group">
							<label class="control-label">支出科目：</label>
							<div class="controls">
								<form:input path="" htmlEscape="false" maxlength="20"/>
							</div>
						</div>
					</td>--%>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">支出金额：</label>
							<div class="controls">
								<input type="text" name="totalAmount" value="${dispatchEmployee.totalAmount}" readonly="true">
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">支出人：</label>
							<div class="controls">
								<sys:treeselect id="payUser" name="payUser.id" value="${employeePayRecord.payUser.id}"
													labelName="payUser.name" labelValue="${employeePayRecord.payUser.name}"
													title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>
								<span class="required help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">备注：</label>
							<div class="controls">
								<form:textarea path="remark" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">确认人：</label>
							<sys:treeselect id="confirmUser" name="confirmUser.id" value="${employeePayRecord.confirmUser.id}"
											labelName="confirmUser.name" labelValue="${employeePayRecord.confirmUser.name}"
											title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" cssClass="required"/>
							<span class="required help-inline"><font color="red">*</font> </span>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">确认时间：</label>
							<input name="confirmTime" id="confirmTime" type="text" readonly="true" maxlength="20" class="input-large Wdate " style="width: 200px"
								   value="<fmt:formatDate value="${employeePayRecord.confirmTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" readonly="readonly" />
						</div>
					</td>
				</tr>
			</table>
		</div>
		<span id="hdAmoutHTML"></span>

		<div class="form-actions">
			<shiro:hasPermission name="crm:employeepayrecord:employeePayRecord:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="确认工资"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>