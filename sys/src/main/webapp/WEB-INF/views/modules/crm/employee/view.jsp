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
                    if (element.is(":checkbox")||element.is(":radio")){
                        error.appendTo(element.parent().parent());
                    }else if(element.parent().is(".input-append")){
                        $(error).text("必填信息");
                        element.parents(".controls").append(error);
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
    <li class="active"><a href="${ctx}/erp/employee/view?id=${employee.id}">基本信息</a></li>
    <li><a href="${ctx}/erp/employee/findEmployeeAppointRecordList?id=${employee.id}">指派记录</a></li>
    <li><a href="${ctx}/erp/employee/findCommunicateHistoryList?id=${employee.id}">沟通记录</a></li>
    <li><a href="${ctx}/erp/employee/findInterviewRecordList?id=${employee.id}">面试记录</a></li>
    <li><a href="#">定级记录</a></li>
    <li><a href="#">服务技能</a></li>
    <li><a href="#">签约记录</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employee" action="${ctx}/erp/employee/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <table>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">员工编号：</label>
                    <div class="controls">
                        <form:input path="code" htmlEscape="false" maxlength="50" class="input-large " readonly="true"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">员工姓名：</label>
                    <div class="controls">
                        <form:input path="name" htmlEscape="false" maxlength="50" class="required input-large " readonly="true"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">手机号码：</label>
                    <div class="controls">
                        <form:input path="phone" htmlEscape="false" maxlength="50" class="required mobile phoneExist" readonly="true"/>
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
                        <form:input path="idcard" htmlEscape="false" maxlength="128" class="required card empCardExist valid" readonly="true"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <form:select path="sex"  class="required input-large " disabled="true">
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
                                value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>" readonly="readonly"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工种：</label>
                    <div class="controls">
                            <form:hidden path="profession"/>
                            <form:checkboxes path="professionList" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class=" input-large" disabled="true"/>
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
                        <%--<sys:treeselect id="customerResource" name="customerResource.id" value="${employee.customerResource.id}"
                                        labelName="customerResource.customerName" labelValue="${employee.customerResource.customerName}"
                                        title="来源名称" url="/erp/customerResource/treeData" cssClass="required" disabled="true"/>--%>
                            <form:input path="customerResource.customerName" htmlEscape="false" maxlength="50" class="input-large" readonly="true" />
                            <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">民族：</label>
                    <div class="controls">
                        <form:select path="nation" class="input-large" disabled="true">
                            <form:options items="${erp:getCommonsTypeList(43)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">推荐人：</label>
                    <div class="controls">
                        <c:if test="${employee.tableType == 1}">
                            <form:input path="customer.name" htmlEscape="false" maxlength="50" class="input-large" readonly="true" />
                        </c:if>
                        <c:if test="${employee.tableType == 2}">
                            <form:input path="user.name" htmlEscape="false" maxlength="50" class="input-large" readonly="true" />
                        </c:if>
                        <c:if test="${employee.tableType == 3}">
                            <form:input path="" htmlEscape="false" maxlength="50" class="input-large" readonly="true" value="${recommendNames}"/>
                        </c:if>
                        <c:if test="${employee.tableType == null}">
                            <input  type="text"   id="recommendName"
                                    style="width:200px;" readonly="readonly" />&nbsp;&nbsp;
                        </c:if>
                    </div>
                </div>
            </td>

        </tr>
        <tr>

            <td>
                <div class="control-group">
                    <label class="control-label">学历：</label>
                    <div class="controls">
                        <form:select path="education" class="input-large" disabled="true" >
                            <form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">婚姻状况：</label>
                    <div class="controls">
                        <form:select path="marriage" class="input-large " disabled="true">
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
                        <form:input path="emergencyContact" htmlEscape="false" maxlength="50" class="required input-large " readonly="true"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人电话：</label>
                    <div class="controls">
                        <form:input path="emergencyContactPhone" htmlEscape="false" maxlength="50" class="required mobile valid" readonly="true" />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
        </tr>
        <tr>

            <%--<td>
                <div class="control-group">
                    <label class="control-label">特长：</label>
                    <div class="controls">
                        <c:if test="${not empty employee.id}">
                            <form:checkboxes path="specialityList" items="${erp:getCommonsTypeList(11)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                        </c:if>
                        <c:if test="${empty employee.id}">
                            <form:checkboxes path="specialityId" items="${erp:getCommonsTypeList(11)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                        </c:if>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>--%>
        </tr>
            <td>
                <div class="control-group">
                    <label class="control-label">籍贯：</label>
                    <div class="controls">
                      <%--  <sys:treeselect id="area" name="originalArea.id" value="${employee.originalArea.id}"
                                        labelName="originalArea.name" labelValue="${employee.originalArea.name}"
                                        title="区域" url="/sys/area/treeData" disabled="true" />--%>
                        <form:input path="originalArea.name" htmlEscape="false" maxlength="50" class="input-large" readonly="true"/>

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
                        <form:textarea path="originalStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" readonly="true"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">现居住地：</label>
                    <div class="controls">
                        <%--<sys:treeselect id="area1" name="currentArea.id" value="${employee.currentArea.id}"
                                        labelName="currentArea.name" labelValue="${employee.currentArea.name}"
                                        title="区域" url="/sys/area/treeData" disabled="true"/>--%>
                        <form:input path="currentArea.name" htmlEscape="false" maxlength="50" class="input-large" readonly="true" />

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
                        <form:textarea path="currentStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" readonly="true" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">信息获取人：</label>
                    <div class="controls">
                        <%--<sys:treeselect id="handleNameId" name="infoCollectId.id" value="${employee.infoCollectId.id}"
                                        labelName="infoCollectId.name" labelValue="${employee.infoCollectId.name}"
                                        title="用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true" allowClear="true" cssClass="required" />--%>
                        <form:input path="infoCollectId.name" htmlEscape="false" maxlength="50" class="input-large" readonly="true"/>
                        <span class="help-inline"><font color="red">*</font> </span>
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
        <td class="2">
            <input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)">
        </td>
    </tr>
    </table>
</form:form>
</body>
</html>