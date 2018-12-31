<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户员工管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<br/>


<form:form id="inputForm" modelAttribute="dispatchEmployee" action="${ctx}/crm/dispatchemployee/saveDispatch?isRepetition=${isRepetition}" method="post" class="form-horizontal">
	<sys:message content="${message}"/>
	<c:if test="${empty result}">
	<strong>选择其他服务人员:</strong>
	<input id="selectEmployee" class="btn btn-primary" type="button" value="选择服务人员"/><br/>
	<input type="hidden" id="dispatchId" name="dispatch.id" value="${dispatch.id}"/>

	<strong>已推荐服务人员:</strong><br/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<%--<th>选择人员</th>--%>
			<th>员工姓名</th>
			<th>员工编号</th>
			<th>技能点</th>
			<th>工作经验(年)</th>
			<th>星级</th>
			<th>服务价格(元)</th>
			<th>推荐时间</th>
			<th>落选原因</th>
			<th>操作</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${employeelist}" var="dispatchEmployee">
			<tr>
				<%--<td>
						${dispatchEmployee.id}
				</td>--%>
				<td>
						${dispatchEmployee.employee.name}
				</td>
				<td>
						${dispatchEmployee.employee.code}
				</td>
				<td>
						${erp:getCommonsTypeName(dispatchEmployee.employee.profession)}
				</td>
				<td>
						${not empty dispatchEmployee.employee.serviceYear? dispatchEmployee.employee.serviceYear:' '}
						<%--${not empty dispatchEmployee.employee.serviceYear? '年':' '}--%>
				</td>
				<td>
						${dispatchEmployee.employee.serviceLevelName}
				</td>
				<td>
						${not empty dispatchEmployee.employee.skillServicePrice? dispatchEmployee.employee.skillServicePrice:' '}
						<%--${not empty dispatchEmployee.employee.skillServicePrice? '元':' '}--%>
				</td>
				<td>
						<fmt:formatDate value="${dispatchEmployee.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					<input type="hidden" name="dispatchEmpId" id="noChecked${dispatchEmployee.id}" disabled="disabled"/>
					<input type="text" name="noCheckedReason" id="reason${dispatchEmployee.id}" dispatchEmpId="${dispatchEmployee.id}"
						   disabled="disabled" class="input-medium" value="${dispatchEmployee.reason}"/>
				</td>
				<td>
					<a id="check${dispatchEmployee.id}" onclick="selectEmployee(
							'${dispatchEmployee.id}','${dispatchEmployee.employee.id}','${dispatchEmployee.employee.name}',
							'${dispatchEmployee.employee.code}','${erp:getCommonsTypeName(dispatchEmployee.employee.profession)}',
							'${not empty dispatchEmployee.employee.serviceYear? dispatchEmployee.employee.serviceYear:' '}',
							'${dispatchEmployee.employee.serviceLevelName}',
							'${not empty dispatchEmployee.employee.skillServicePrice? dispatchEmployee.employee.skillServicePrice:' '}')"
					   dispatchEmpPojoId="${dispatchEmployee.id}" href="javascript:;">选择</a>
					<span id="hasChecked${dispatchEmployee.id}" hidden="hidden">已选择</span>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>

	<strong>选中的服务人员:</strong><br/>

	<table id="empTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<%--<th>dispatchEmpId</th>
			<th>empId</th>--%>
			<th>员工姓名</th>
			<th>员工编号</th>
			<th>技能点</th>
			<th>工作经验(年)</th>
			<th>星级</th>
			<th>结算价格(元)</th>
				<%--<th>操作</th>--%>
		</tr>
		</thead>
		<tbody id="employeeTable">
		<tr>
			<%--<td>
				<div id="dispatchEmpId"></div>
			</td>
			<td><div id="empId"></div></td>--%>
			<td>
				<div id="empName"></div>
				<input type="hidden" name="id" id="checkedDispatchEmpId" />
			</td>
			<td><div id="code"></div></td>
			<td><div id="profession"></div></td>
			<td><div id="serviceYear"></div></td>
			<td><div id="serviceLevelName"></div></td>
			<td><div id="skillServicePrice"></div></td>
				<%--<td>
                    &lt;%&ndash;<input type="hidden" name="dispatchEmpId" value="{{dispatchEmpId}}">
                    <input id="removeEmp{{dispatchEmpId}}" class="btn btn-danger" type="button" value="删 除"
                           onclick="removeEmp('{{dispatchEmpId}}')"/>&ndash;%&gt;
                </td>--%>
		</tr>
		</tbody>

	</table>

	<div class="control-group">
		<label class="control-label">预约上户时间：</label>
		<div class="controls">
			<input name="dispatch.planStartTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${dispatchEmployee.dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});" />
				<%--&nbsp;至&nbsp;
			<input name="dispatch.planEndTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
				   value="<fmt:formatDate value="${dispatchEmployee.dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>--%>
			<span class="help-inline">
				<font color="red">*</font>
			</span>
		</div>
	</div>

		<div class="control-group">
			<label class="control-label">预约下户时间：</label>
			<div class="controls">
				<input name="dispatch.planEndTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					   value="<fmt:formatDate value="${dispatchEmployee.dispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
				<span class="help-inline">
				<font color="red">*</font>
			</span>
			</div>
		</div>

	<div class="control-group">
		<label class="control-label">服务结算方式：</label>
		<div class="controls">
			<%--<form:radiobuttons path="dispatch.payType" items="${erp:dispatchPayTypeName(dispatchEmployee.dispatch.payType)}" itemLabel="name" itemValue="value" htmlEscape="false" class="required"/>--%>
			<input type="radio"  name="dispatch.payType"  value="2" class="required" checked="checked"/>按商品结算价结算
			<input type="radio"  name="dispatch.payType"  value="1" class="required"/>按服务人员结算价结算
			<%--<input type="radio"  name="dispatch.payType"  value="2"  checked="checked"/>按商品结算价结算--%>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>

	<div class="form-actions">
			<%--<shiro:hasPermission name="crm:dispatchEmployee:save">--%>
		<input id="btnFormSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<%--</shiro:hasPermission>--%>
		<input name="closeWindows" class="btn" type="button" value="关闭"/>
	</div>

	</c:if>
	<c:if test="${!empty result}">
		<div class="form-actions">
			<c:choose>
				<c:when test="${result == 'success'}">
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>派工成功</div>
				</c:when>
				<c:otherwise>
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>派工失败</div>
				</c:otherwise>
			</c:choose>

			<input name="closeWindows" class="btn" type="button" value="关 闭"/>
		</div>
	</c:if>

</form:form>

<script>
    var dispatchEmployeeArray = new Array();

    $(document).ready(function() {
		//alert(${dispatch.id});
        $("input[name='closeWindows']").each(function () {
            $(this).click(function () {
                top.$.jBox.close(true);
            });
        });

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

        //隐藏原有已派工人员
        /*var isRepetition = ${isRepetition};
        if(isRepetition==1){
            $(document).find("input[name='noCheckedReason']").each(function () {
                var currentDispatchEmpId = $(this).attr("dispatchEmpId");
                if($(this).val()==''||$(this).val()==null||$(this).val()==undefined) { //未选中的
                    $("#check"+ currentDispatchEmpId).attr("hidden","hidden");

                    $(this).attr("isrepetition","1");
                }else {
                    $(this).attr("isrepetition", "0");
                }
            });
        }*/

        $("#selectEmployee").click(function () {
            var dispatchId = $("#dispatchId").val();
            top.$.jBox.open("iframe:/crm/dispatchemployee/service",
                "推荐服务人员",
                1024,
                550,
                {
                    closed:function () {reloadAfterCloseMethod()},
                    ajaxData:{"dispatchId":dispatchId,"tagFlag":1}
                }
            );
        });

        //选择服务人员
        /*$("#selectEmployee").click(function () {
            employeeJbox =  top.$.jBox("iframe:/crm/dispatchemployee/service?dispatchId="+$("#dispatchId").val(),{
                title:"推荐服务人员",
                width:1024,
                height:550,
                buttons:{}
            });
        });*/

        //appendTable();
    });

    function reloadAfterCloseMethod() {
        window.location.reload(true);
    }

    //选择员工  profession,serviceYear,serviceLevelName,servicePrice);
    function selectEmployee(checkdispatchEmpId,empId,empName,code,profession,serviceYear,serviceLevelName,servicePrice){
        //console.log("#chkEmp"+checkdispatchEmpId+"--"+empName+"--"+code+"--"+empId+""+"--"+""+"--"+""+"--"+""+"--"+"");

		/*var checkDispatchEmpId = $("#dispatchEmpId").text();
		 $("#check"+checkDispatchEmpId).removeAttr("hidden","hidden");
		 $("#hasChecked"+checkDispatchEmpId).attr("hidden","hidden");*/

		/*$("#dispatchEmpId").text(dispatchEmpId);
		 $("#checkedDispatchEmpId").val(dispatchEmpId);
		 $("#empId").text(empId);
		 $("#empName").text(empName);
		 $("#code").text(code);

		 $("#check"+dispatchEmpId).attr("hidden","hidden");
		 $("#hasChecked"+dispatchEmpId).removeAttr("hidden","hidden");*/


        //重置空值
        $(document).find("input[name='noCheckedReason']").each(function () {
            var currentDispatchEmpId = $(this).attr("dispatchEmpId");
            $("#reason" + currentDispatchEmpId).val("");
            $("#noChecked"+ currentDispatchEmpId).val("");
            $("#checkedDispatchEmpId").val("");
        });

        $(document).find("input[name='noCheckedReason']").each(function () {
            var currentDispatchEmpId = $(this).attr("dispatchEmpId");
            var isrepetition = $(this).attr("isrepetition");
            if(currentDispatchEmpId!=checkdispatchEmpId) { //未选中的
                $("#reason" + currentDispatchEmpId).removeAttr("disabled", "disabled");
                $("#noChecked"+ currentDispatchEmpId).removeAttr("disabled", "disabled");
                $("#check"+ currentDispatchEmpId).removeAttr("hidden","hidden");
                $("#hasChecked"+ currentDispatchEmpId).attr("hidden","hidden");

                $("#noChecked"+ currentDispatchEmpId).val(currentDispatchEmpId);
            }else{  //选中的
                $("#reason" + checkdispatchEmpId).attr("disabled", "disabled");
                $("#noChecked"+ currentDispatchEmpId).attr("disabled", "disabled");
                $("#check"+ checkdispatchEmpId).attr("hidden","hidden");
                $("#hasChecked"+ checkdispatchEmpId).removeAttr("hidden","hidden");

                //$("#dispatchEmpId").text(checkdispatchEmpId);
                $("#checkedDispatchEmpId").val(checkdispatchEmpId);

                //$("#empId").text(empId);
                $("#empName").text(empName);
                $("#code").text(code);
                $("#profession").text(profession);
                $("#serviceYear").text(serviceYear);
                $("#serviceLevelName").text(serviceLevelName);
                $("#skillServicePrice").text(servicePrice);
            }
        });

		/*$("#check"+checkdispatchEmpId).attr("hidden","hidden");
		 $("#hasChecked"+checkdispatchEmpId).removeAttr("hidden","hidden");*/

    }

</script>
</body>
</html>