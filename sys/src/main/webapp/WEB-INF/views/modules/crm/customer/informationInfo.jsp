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

			<li><a href="${ctx}/crm/customer/info?id=${customer.id}&&tagFlag=${tagFlag}">基本信息</a></li>
			<li class="active"><a href="${ctx}/crm/customer/informationInfo?id=${customer.id}&&tagFlag=${tagFlag}">扩展信息</a></li>
			<li><a href="${ctx}/crm/customer/delegateInfo?id=${customer.id}&&tagFlag=${tagFlag}">委派记录</a></li>
			<li><a href="${ctx}/crm/customer/followInfo?id=${customer.id}&&tagFlag=${tagFlag}">跟进记录</a></li>
			<li><a href="${ctx}/crm/customer/saleInfo?id=${customer.id}&&tagFlag=${tagFlag}">销售线索</a></li>
			<li><a href="${ctx}/crm/customer/orderInfo?id=${customer.id}&&tagFlag=${tagFlag}">订单信息</a></li>
			<li><a href="${ctx}/crm/customer/contractInfo?id=${customer.id}&&tagFlag=${tagFlag}">合同信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customer" action="${ctx}/crm/customer/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="alert alert-info">扩展信息</div>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">证件类型：</label>
						<div class="controls">
							<form:select path="information.credentials" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(58)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">证件号码：</label>
						<div class="controls">
							<form:input path="information.idNumber" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">分娩医院：</label>
						<div class="controls">
							<form:input path="information.hospital" htmlEscape="false" maxlength="50" readonly="true" />
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">分娩方式：</label>
						<div class="controls">
							<form:input path="information.delivery" htmlEscape="false" maxlength="50"  readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">预产期：</label>
						<div class="controls">
							<input name="information.deliveryTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.information.deliveryTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">所属单位：</label>
						<div class="controls">
							<form:input path="information.unit" htmlEscape="false" maxlength="50" readonly="true" />
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">所属部门：</label>
						<div class="controls">
							<form:input path="information.department" htmlEscape="false" maxlength="50"  readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">职位：</label>
						<div class="controls">
							<form:input path="information.job" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">学历：</label>
						<div class="controls">
							<form:select path="information.education" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(7)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">毕业院校：</label>
						<div class="controls">
							<form:input path="information.school" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">毕业年份：</label>
						<div class="controls">
							<input name="information.graduationTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.information.graduationTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">星座：</label>
						<div class="controls">
							<form:select path="information.constellation" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(56)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">血型：</label>
						<div class="controls">
							<form:select path="information.blood" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(57)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">客户偏好：</label>
						<div class="controls">
							<form:textarea path="information.remark" htmlEscape="false" rows="4" maxlength="200"  style="width: 350px;" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
		</table>

		<div class="alert alert-info">家庭信息</div>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">家庭人口：</label>
						<div class="controls">
							<form:input path="family.peoples" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">家庭成员：</label>
						<div class="controls">
							<form:input path="family.member" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无宝宝：</label>
						<div class="controls">
							<form:select path="family.babyStatus" class="input-large " disabled="true">
								<form:options items="${erp:babyStatusesList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">宝宝数量：</label>
						<div class="controls">
							<form:input path="family.babyNumber" htmlEscape="false" maxlength="50" readonly="true" />
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">客户与宝宝的关系：</label>
						<div class="controls">
							<form:select path="family.relation" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(60)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">其他：</label>
						<div class="controls">
							<form:input path="family.rests" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">宝宝姓名：</label>
						<div class="controls">
							<form:input path="customerBaby.name" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">宝宝性别：</label>
						<div class="controls">
							<form:select path="customerBaby.sex" class="input-large " disabled="true">
								<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">宝宝出生日期：</label>
						<div class="controls">
							<input name="customerBaby.birthTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.customerBaby.birthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">宝爸姓名：</label>
						<div class="controls">
							<form:input path="family.fatherName" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<form:input path="family.fatherPhone" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="family.fatherBirthTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.family.fatherBirthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">星座：</label>
						<div class="controls">
							<form:select path="family.fatherConstellation" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(56)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">血型：</label>
						<div class="controls">
							<form:select path="family.fatherBlood" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(57)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">职业：</label>
						<div class="controls">
							<form:input path="family.fatherJob" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">宝妈姓名：</label>
						<div class="controls">
							<form:input path="family.motherName" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">联系方式：</label>
						<div class="controls">
							<form:input path="family.motherPhone" htmlEscape="false" maxlength="50" readonly="true"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">出生日期：</label>
						<div class="controls">
							<input name="family.motherBirthTime" type="text" maxlength="20" class="input-medium Wdate " style="width: 210px"
								   value="<fmt:formatDate value="${customer.family.motherBirthTime}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" readonly="true"/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">星座：</label>
						<div class="controls">
							<form:select path="family.motherConstellation" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(56)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">血型：</label>
						<div class="controls">
							<form:select path="family.motherBlood" class="input-large" disabled="true">
								<form:options items="${erp:getCommonsTypeList(57)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">职业：</label>
						<div class="controls">
							<form:input path="family.motherJob" htmlEscape="false" maxlength="50" readonly="true" />
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