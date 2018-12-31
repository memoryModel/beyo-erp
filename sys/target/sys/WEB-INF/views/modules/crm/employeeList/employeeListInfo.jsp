<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工入职签约管理管理</title>
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
    <li><shiro:hasPermission name="crm:entry:list"><a href="${ctx}/crm/entry/list">入职签约管理</a></shiro:hasPermission></li>
    <li class="active"><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/entry/info?id=${entry.id}">详细信息</a></li></shiro:hasPermission>
    <li><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/view?employeeId=${entry.employee.id}&entryId=${entry.id}">资历信息</a></shiro:hasPermission></li>
    <li><shiro:hasPermission name="erp:employeeInfo:getEmployeeExperienceInfo"><a href="${ctx}/erp/employeeInfo/view?employeeId=${entry.employee.id}&entryId=${entry.id}">认证信息</a></shiro:hasPermission></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/entry/saves" method="post" class="form-horizontal">
<%--<form:hidden path="id"/>--%>
<sys:message content="${message}"/>
<div class="alert alert-info">基本信息</div>

<div class="control-group">
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">员工编号：</label>
                    <div class="controls" >
                            ${employee.code}
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">手机号码：</label>
                    <div class="controls">
                        <form:input path="employee.phone" htmlEscape="false" maxlength="50"  class=" simplePhone input-large"  readonly="true"/>

                    </div>
                </div>
            </td>

        </tr>
        <tr>

            <td>
                <div class="control-group">
                    <label class="control-label">身份证号：</label>
                    <div class="controls">
                        <form:input path="employee.idcard" htmlEscape="false" maxlength="50"  class=" card input-large "   readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">来源：</label>
                    <div class="controls">
                        <form:hidden path="employee.customerResource.id" htmlEscape="false" maxlength="50"  class="  input-large "   readonly="true"/>

                        <form:input path="employee.customerResource.customerName" htmlEscape="false" maxlength="50"  class="  input-large "   readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">姓名：</label>
                    <div class="controls">
                        <form:input path="employee.name" htmlEscape="false" maxlength="50" class=" input-large " readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">出生日期：</label>
                    <div class="controls">
                        <input name="employee.birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium "
                               value="<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">特长：</label>
                    <div class="controls">
                        <form:hidden path="employee.specialityId"/>
                        <form:checkboxes path="employee.specialityList" items="${erp:getCommonsTypeList(11)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class=" input-large" disabled="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">专业：</label>
                    <div class="controls">
                        <form:select path="employee.profession" class="required input-large" disabled="true">
                            <form:options items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <form:select path="employee.sex" class="required input-large" disabled="true">
                            <form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">最高学历：</label>
                    <div class="controls">
                        <form:select path="employee.education" class="required input-large" disabled="true">
                            <form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">婚姻状况：</label>
                    <div class="controls">
                        <form:select path="employee.marriage" class="required input-large " disabled="true">
                            <form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">民族：</label>
                    <div class="controls">
                        <form:select path="employee.nation" class="required input-large" disabled="true">
                            <form:options items="${erp:getCommonsTypeList(43)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" />
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
                        <form:input path="employee.emergencyContact" htmlEscape="false" maxlength="50" class="required input-large " readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人电话：</label>
                    <div class="controls">
                        <form:input path="employee.emergencyContactPhone" htmlEscape="false" maxlength="50" class="required mobile input-large" readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>
        <td>
            <div class="control-group">
                <label class="control-label">籍贯：</label>
                <div class="controls">
                        ${entry.employee.originalArea.name}

                </div>
            </div>
        </td>
        <td>
            <div class="control-group">
                <label class="control-label">籍贯地址：</label>
                <div class="controls">
                    <form:input path="employee.originalStreet" htmlEscape="false"  maxlength="1024" class="required input-large " readonly="true"/>

                </div>
            </div>
        </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">现居住地：</label>
                    <div class="controls">
                            ${entry.employee.currentArea.name}

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">现居住地地址：</label>
                    <div class="controls">
                        <form:input path="employee.currentStreet" htmlEscape="false"  maxlength="1024" class="required input-large " readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">服务城市：</label>
                    <div class="controls">
                        <form:input path="employee.serviceCity" htmlEscape="false" maxlength="50"  class="required input-large "  readonly="true"/>

                    </div>
                </div>
            </td>

            <td>
                <div class="control-group">
                    <label class="control-label">服务年限：</label>
                    <div class="controls">
                        <form:input path="employee.serviceYear" htmlEscape="false" maxlength="50"  class="required digits input-large "  readonly="true"/>

                    </div>
                </div>
            </td>

        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">爱好：</label>
                    <div class="controls">
                        <form:input path="employee.hobby" htmlEscape="false" maxlength="50"  class="required input-large "  readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">星座：</label>
                    <div class="controls">
                        <form:input path="employee.constellation" htmlEscape="false" maxlength="50"  class="required input-large "   readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>

        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">血型：</label>
                    <div class="controls">
                        <form:input path="employee.blood" htmlEscape="false" maxlength="50"  class="required input-large "   readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">座右铭：</label>
                    <div class="controls">
                        <form:input path="employee.motto" htmlEscape="false" maxlength="50"  class="input-large "  readonly="true"/>
                    </div>
                </div>
            </td>


        </tr>



        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">外语种类：</label>
                    <div class="controls">
                        <form:input path="employee.language" htmlEscape="false" maxlength="50"  class="required  input-large"   readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">外语等级：</label>
                    <div class="controls">
                        <form:select path="employee.english" class="required input-large"  disabled="true">
                            <form:options items="${erp:getCommonsTypeList(46)}" itemLabel="commonsName"   itemValue="id" htmlEscape="false"/>
                        </form:select>

                    </div>
                </div>
            </td>

        </tr>

        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">年龄：</label>
                    <div class="controls">
                        <form:input path="employee.age" htmlEscape="false" maxlength="50"  class="required input-large digits"  readonly="true"/>

                    </div>
                </div>
            </td>

        </tr>

        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">是否住宿：</label>
                    <div class="controls">
                        <form:radiobuttons path="employee.dormStatus" items="${erp:roomStatusList()}" itemLabel="name" itemValue="value" cssClass="required" disabled="true"/>


                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div class="control-group">
                    <label class="control-label">员工性质：</label>
                    <div class="controls">
                        <form:select path="employee.type" class="input-large" disabled="true" >
                            <form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value"  htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

<div class="alert alert-info">合同信息</div>
<div class="control-group">
    <label class="control-label">合同编号: </label>
    <div class="controls">
            ${entry.contractCode}
    </div>
</div>
<div class="alert alert-info">财务信息</div>
<div class="control-group">
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">有无底薪：</label>
                    <div class="controls">
                        <form:select path="basePayStatus" class="required input-large" disabled="true">
                            <form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value"  htmlEscape="false"/>
                        </form:select>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">底薪(元): </label>
                    <div class="controls">
                        <form:input path="baseAmount" htmlEscape="false" maxlength="50" class="required input-large money"  readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">所属银行1: </label>
                    <div class="controls">
                        <form:input path="bankName" htmlEscape="false" maxlength="50" class="required input-large "  readonly="true"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工资卡号1: </label>
                    <div class="controls">
                        <form:input path="bankNumber" htmlEscape="false" maxlength="50" class="required input-large "   readonly="true"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">所属银行2: </label>
                    <div class="controls">
                        <form:input path="secondBankName" htmlEscape="false" maxlength="50" class="input-large "   readonly="true"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工资卡号2: </label>
                    <div class="controls">
                        <form:input path="secondBankNumber" htmlEscape="false" maxlength="50" class="input-large "   readonly="true"/>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</div>

<div class="alert alert-info">员工等级</div>
<table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width:90%;">
    <thead>
    <tr>
        <th>基础服务技能项</th>
        <th>等级</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${employeeSkillList}" var="employeeSkill">
        <c:if test="${employeeSkill.skill.category==2}">
            <tr>
                <td>${employeeSkill.skill.skillName}</td>
                <td>${employeeSkill.serviceLevel.name}</td>
            </tr>
        </c:if>

    </c:forEach>
    </tbody>
</table>
<div class="alert alert-info">员工升降级记录</div>
<div class="control-group">
    <table  class="table table-striped table-bordered table-condensed" style="width:90%;">
        <thead>
        <tr>
            <th>基础服务技能项</th>
            <th>原等级</th>
            <th>评测后级别</th>
            <th>原结算价格</th>
            <th>现结算价格</th>
            <th>测评人</th>
            <th>测评时间</th>
            <th>测评结果</th>
            <th>审批人</th>
            <th>审批时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeLevelApproveList}" var="approve">
            <tr>
                <td>
                        ${approve.skill.skillName}
                </td>

                <td>
                        ${approve.lastServiceLevel.name}
                </td>
                <td>
                        ${approve.serviceLevel.name}
                </td>
                <td>
                        ${approve.lastAmount}
                </td>

                <td>
                        ${approve.serviceAmount}
                </td>
                <td>
                        ${approve.testUser.name}
                </td>
                <td>
                    <fmt:formatDate value="${approve.testTime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
                <td>
                        ${erp:approveStatusName(approve.status)}
                </td>
                <td>
                        ${approve.approveUser.name}
                </td>
                <td>
                    <fmt:formatDate value="${approve.approveTime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div id="contentTable" class="alert alert-info">技能项</div>
    <table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width:90%;">
        <thead>
        <tr>
            <th>技能名称</th>
            <th>结算价格(元)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeSkillList}" var="employeeSkill">
            <tr>
                <td>
                        ${employeeSkill.skill.skillName}

                </td>
                <td>${employeeSkill.servicePrice}
                    <c:if test="${employeeSkill.skill.unit == 1}">
                        &nbsp;元/天
                    </c:if>
                    <c:if test="${employeeSkill.skill.unit == 2}">
                        &nbsp;元/次
                    </c:if>
                </td>
            </tr>


        </c:forEach>
        </tbody>
    </table>
    <%--<tr>
        <td>
            <div class="control-group">
                <label class="control-label">基础服务结算方式：</label>
                <form:radiobuttons path="settleStatus" items="${erp:settleStatusList()}" itemLabel="name" itemValue="value" disabled="true"/>
            </div>
        </td>
    </tr>--%>

    <div class="alert alert-info">视频秀</div>
    <table style="width: 500px; height: 150px;">
        <tbody>
        <c:forEach items="${employeeInfoList}" var="employeeInfo">
            <c:if test="${employeeInfo.type == 4}">
                <tr>
                    <td><img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/></td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>
    <div class="alert alert-info">作品秀</div>
    <table>
        <tbody>
        <c:forEach items="${employeeInfoList}" var="employeeInfo">
            <c:if test="${employeeInfo.type == 5}">
                <tr>
                    <td><img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/></td>
                </tr>
            </c:if>
        </c:forEach>
        </tbody>
    </table>

    <div class="form-actions">
        <shiro:hasPermission name="erp:employee:edit">&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
    </form:form>
</body>
</html>