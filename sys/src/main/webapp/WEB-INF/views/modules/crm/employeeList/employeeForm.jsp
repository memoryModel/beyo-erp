<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
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
            var jbox;
            $("#selectCustomer").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectCustomer", "选择客户", 1024, 520);
            });
            $("#selectUser").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectUser", "选择员工", 1024, 520);
            });
            $("#selectServicePeople").click(function () {
                jbox =  top.$.jBox.open("iframe:/erp/employee/selectServicePeople", "选择服务人员", 1024, 520);
            });

            jQuery.validator.addMethod("empCardExist", function(value, element) {
                var isExist = value.toString().substring(6,10)+'-'+value.toString().substring(10,12)+'-'+value.toString().substring(12,14);
                $('[name="birthTime"]').val(isExist);
                if($("#oldempCard").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/erp/employee/isExist",
                    data:"idcard="+value,
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
            }, "身份证号已存在");
            jQuery.validator.addMethod("phoneExist", function(value, element) {
                if($("#oldphone").val()==value)return true;
                var flag = false;
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/erp/employee/phoneExist",
                    data:"phone="+value,
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

            $("#btnSubmit").click(function(){

                if ($('#checkBoxId').attr('checked')) {
                    var cid = '${communicateId}';
                    $("#communicateId").val(cid);
                }
            });
            var flag = '${flag}'
            if(flag != null && flag == 'n'){
                $('#selectCustomer').hide();
                $('#selectUser').hide();
                $('#selectServicePeople').hide();
                var idValue = '${employee.infoCollectId.id}'
                var nameValue = $('#hdNameValue').val()
                $('#divHandleNameId').empty().append('<input name="infoCollectId.id" type="hidden" value='+idValue+'>' +
                    '<input type="text" readonly="readonly" value='+nameValue+'>');

                $('[myProperty]').attr("readonly",true);
                $('[name="createTime"]').attr("readonly",true);
            }

        });
        function selectCustomerCallback(customerId,names){
            console.log("#btnSelect"+customerId+names);
            $("#tableType").val("1");
            $("#recommendId").val(customerId);
            $("#recommendName").val(names);
        }
        function selectUserCallback(userId,name){
            console.log("#btnSelect"+userId+name);
            $("#tableType").val("2");
            $("#recommendId").val(userId);
            $("#recommendName").val(name);

        }

        function selectServicePeopleCallback(servicePeopleId,name){
            console.log("#btnSelect"+servicePeopleId+name);
            $("#tableType").val("3");
            $("#recommendId").val(servicePeopleId);
            $("#recommendName").val(name);
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/erp/employee/form?id=${employee.id}">基本信息<shiro:hasPermission name="erp:employee:form">${not empty employee.id?'修改':'添加'}</shiro:hasPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employee" action="${ctx}/erp/employee/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <input type="hidden" value="${employee.idcard}" id="oldempCard">
    <input type="hidden" value="${employee.phone}" id="oldphone">
    <input type="hidden" id="recommendId" name="recommendId" >
    <input type="hidden" id="communicateId" name="communicateId">
    <input type="hidden" value="${employee.signStatus}" id="signStatus" name="signStatus">
    <input type="hidden" value="${employee.code}" id="code" name="code">
    <input type="hidden" value="${employee.creater.id}" id="creater.id" name="creater.id">
    <input type="hidden" value="${employee.createTime}" id="createTime" name="createTime">
    <input type="hidden"  name="tableType" id="tableType"/>
    <sys:message content="${message}"/>
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">员工姓名：</label>
                    <div class="controls">
                        <form:input path="name" htmlEscape="false" maxlength="50" class="required input-large " />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">手机号码：</label>
                    <div class="controls">
                        <form:input path="phone" htmlEscape="false" maxlength="50" class="required mobile phoneExist"  />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">身份证号：</label>
                    <div class="controls">
                        <form:input path="idcard" htmlEscape="false" maxlength="128" class="required card empCardExist valid" />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <form:select path="sex"  class="required input-large ">
                            <form:option value="" label="------请选择------"/>
                            <form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
                        </form:select>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>

        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">出生日期：</label>
                    <div class="controls">
                        <input  name="birthTime" type="text" class="input-medium Wdate "
                                value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </div>
                </div>
            </td>
            <td>
                    <div class="control-group">
                        <label class="control-label">工种：</label>
                        <div class="controls">
                            <c:if test="${not empty employee.id}">
                                <form:checkboxes path="professionList" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                            </c:if>
                            <c:if test="${empty employee.id}">
                                <form:checkboxes path="profession" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                            </c:if>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">来源：</label>
                    <div class="controls">
                        <sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
                                        labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
                                        title="来源名称" url="/erp/customerResource/treeData" cssClass="required" />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">民族：</label>
                    <div class="controls">
                        <form:select path="nation" class="input-large" >
                            <form:option value="" label="------请选择------"/>
                            <form:options items="${erp:getCommonsTypeList(43)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>

        <tr>

            <td>
                <div class="control-group">
                    <label class="control-label">学历：</label>
                    <div class="controls">
                        <form:select path="education" class="input-large" >
                            <form:option value="" label="------请选择------"/>
                            <form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">婚姻状况：</label>
                    <div class="controls">
                        <form:select path="marriage" class="input-large " >
                            <form:option value="" label="------请选择------"/>
                            <form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>

            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人：</label>
                    <div class="controls">
                        <form:input path="emergencyContact" htmlEscape="false" maxlength="50" class="required input-large "/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人电话：</label>
                    <div class="controls">
                        <form:input path="emergencyContactPhone" htmlEscape="false" maxlength="50" class="required mobile valid" />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">籍贯：</label>
                    <div class="controls">
                        <sys:treeselect id="area" name="originalArea.id" value="${employee.originalArea.id}"
                                        labelName="originalArea.name" labelValue="${employee.originalArea.name}"
                                        title="区域" url="/sys/area/treeData" />
                    </div>
                </div>
            </td>
            <td>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">籍贯地址：</label>
                    <div class="controls">
                        <form:textarea path="originalStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">现居住地：</label>
                    <div class="controls">
                        <sys:treeselect id="area1" name="currentArea.id" value="${employee.currentArea.id}"
                                        labelName="currentArea.name" labelValue="${employee.currentArea.name}"
                                        title="区域" url="/sys/area/treeData"/>
                    </div>
                </div>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">现居住地地址：</label>
                    <div class="controls">
                        <form:textarea path="currentStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">信息获取人：</label>
                    <div class="controls" id="divHandleNameId">
                        <sys:treeselect id="handleNameId" name="infoCollectId.id" value="${employee.infoCollectId.id}"
                                        labelName="infoCollectId.name" labelValue="${employee.infoCollectId.name}"
                                        title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                        <input id="hdNameValue" type="hidden" value="${employee.infoCollectId.name}">
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">信息添加人：</label>
                    <div class="controls">
                        <form:input path="creater.name" htmlEscape="false"  maxlength="1024" class="input-large " readonly="true" value="${createUserName}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">添加时间：</label>
                    <div class="controls">
                        <input  name="createTime" type="text"  class="input-medium Wdate "
                                value="<fmt:formatDate value="${employee.createTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly="readonly"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="9">
                <div class="form-actions">
                    <shiro:hasPermission name="erp:employee:save"><input  class="btn btn-primary" type="submit" id="btnSubmit" value="保 存"/>&nbsp;</shiro:hasPermission>
                    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
                </div>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>