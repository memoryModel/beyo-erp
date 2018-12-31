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
    <li><a href="${ctx}/crm/employeeResign/list">待入职列表</a></li>
    <li class="active"><a href="${ctx}/crm/employeeResign/getEmployeeInfo?id=${employee.id}">员工信息</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="employee" action="${ctx}/crm/entry/saves" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="alert alert-info">基本信息</div>
    <table>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">员工编号：</label>
                    <div class="controls">
                            ${employee.code}
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">姓名：</label>
                    <div class="controls">
                        <form:input path="name" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${employee.name}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">电话：</label>
                    <div class="controls">
                        <form:input path="phone" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${employee.phone}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">身份证号：</label>
                    <div class="controls">
                        <form:input path="empCard" htmlEscape="false" maxlength="50" class="input-large "  readonly="true" style="width:210px;" value="${employee.idcard}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">婚姻状态：</label>
                    <div class="controls">
                        <form:input path="maritalStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${erp:marriageStatusName(employee.maritalStatus)}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">员工出生日期：</label>
                    <div class="controls">
                        <input name="birthTime" type="text" readonly="readonly" maxlength="20"  style="width:210px;"
                               value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">最高学历：</label>
                    <div class="controls">
                        <form:input path="education" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${employee.highestEducation.commonsName}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">民族：</label>
                    <div class="controls">
                        <form:input path="nation.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${employee.nation.commonsName}"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">籍贯：</label>
                    <div class="controls">
                        <form:input path="originalArea.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${employee.originalArea.name}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">详细地址：</label>
                    <div class="controls">
                        <form:input path="originalStreet" htmlEscape="false"  maxlength="1024" readonly="true" class="input-xlarge " style="width:210px;" />
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人：</label>
                    <div class="controls">
                        <form:input path="emergencyContact" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${employee.emergencyContact}"/>

                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系电话：</label>
                    <div class="controls">
                        <form:input path="emergencyContactPhone" htmlEscape="false" maxlength="50" readonly="true" class="input-large " style="width:210px;"  value="${employee.emergencyContactPhone}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">来源：</label>
                    <div class="controls">
                        <form:input path="customerResource.id" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${employee.customerResource.customerName}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">血型：</label>
                    <div class="controls">
                        <form:input path="blood" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.blood}"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">年龄：</label>
                    <div class="controls">
                        <form:input path="age" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.age}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">座右铭：</label>
                    <div class="controls">
                        <form:input path="motto" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.motto}"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">爱好：</label>
                    <div class="controls">
                        <form:input path="hobby" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.hobby}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工种：</label>
                    <div class="controls">
                        <form:checkboxes path="profession" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">外语种类：</label>
                    <div class="controls">
                        <form:input path="language" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.language}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">外语等级：</label>
                    <div class="controls">
                        <form:input path="englishLevel.id" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${employee.englishLevel.commonsName}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">是否住宿：</label>
                    <div class="controls">
                        <input type="radio"  name="dormStatus"  value="1" <c:if test="${employee.dormStatus == 1}">checked</c:if>/>住宿
                        <input type="radio"  name="dormStatus"  value="0" <c:if test="${employee.dormStatus == 0}">checked</c:if>/>不住宿
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">星座：</label>
                    <div class="controls">
                        <form:input path="constellation" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.constellation}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">服务城市：</label>
                    <div class="controls">
                        <form:input path="serveCity" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.serveCity}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">服务年限：</label>
                    <div class="controls">
                        <form:input path="serviceTime" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${employee.serviceTime}"/>

                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">员工性质：</label>
                    <div class="controls">
                        <form:input path="employeeNature" htmlEscape="false" readonly="true" maxlength="50" class="input-xlarge " style="width:210px;" value="${erp:erviceStatusName(employee.employeeNature)}"/>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div class="alert alert-info">合同信息</div>
    <div class="control-group">
        <label class="control-label">合同编号: </label>
        <div class="controls">
            <form:input path="entry.code" htmlEscape="false" maxlength="50" readonly="true" value="${employee.entry.code}" class="input-xlarge " style="width:210px;"/>
        </div>
    </div>
    <div class="alert alert-info">财务信息</div>
    <table style="width: 80%">
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">有无欠款：</label>
                    <div class="controls">
                        <form:input path="entry.debtStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${erp:debtStatusName(employee.entry.debtStatus)}"/>
                    </div>

                </div>

            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">底薪(元): </label>
                    <div class="controls">
                        <form:input path="entry.pay" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.pay}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工资卡号1: </label>
                    <div class="controls">
                        <form:input path="entry.idCard" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.idCard}"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">所属银行1: </label>
                    <div class="controls">
                        <form:input path="entry.bank" htmlEscape="false" maxlength="50" class="input-large " readonly="true"  style="width:150px;" value="${employee.entry.bank}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">工资卡号2: </label>
                    <div class="controls">
                        <form:input path="entry.idCarda" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.idCarda}"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">所属银行2: </label>
                    <div class="controls">
                        <form:input path="entry.banka" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.banka}"/>
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <div class="alert alert-info">员工等级</div>
    <table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
        <thead>
        <tr>
            <th>基础服务技能项</th>
            <th>等级</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeSkillList}" var="employeeSkill">
            <tr>
                <td>${employeeSkill.skill.skillName}</td>
                <td>${employeeSkill.serviceLevel.name}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="alert alert-info">员工升降级记录</div>
    <table id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
        <thead>
        <tr>
            <th>基础服务技能项</th>
            <th>原等级</th>
            <th>评测后级别</th>
            <th>原服务介绍价格</th>
            <th>测评后服务结算价格</th>
            <th>测评人</th>
            <th>测评时间</th>
            <th>测评结果</th>
            <th>审批人</th>
            <th>审批时间</th>
            <th>审批意见</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeLevelApproveList}" var="employeeLevelApprove">
            <tr>
                <td>
                        ${employeeLevelApprove.skill.skillName}
                </td>
                <td>
                        ${employeeLevelApprove.serviceLevel.name}
                </td>
                <td>
                        ${employeeLevelApprove.employeeSkill.serviceLevel.name}
                </td>

                <td>
                        ${employeeLevelApprove.employeeSkill.servicePrice}
                </td>

                <td>
                        ${employeeLevelApprove.newLevelAmount}
                </td>
                <td>
                        ${employeeLevelApprove.testName.name}
                </td>
                <td>
                    <fmt:formatDate value="${employeeLevelApprove.evaluationTime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
                <td>
                        ${employeeLevelApprove.testResult}
                </td>
                <td>
                        ${employeeLevelApprove.approveName.name}
                </td>
                <td>
                    <fmt:formatDate value="${employeeLevelApprove.approveTime}" pattern="yyyy-MM-dd HH:mm"/>
                </td>
                <td>
                        ${employeeLevelApprove.approveReason}
                </td>

            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div id="contentTable" class="alert alert-info">技能项</div>
    <table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width: 80%">
        <thead>
        <tr>
            <th>技能名称</th>
            <th>结算价格(元)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeSkillList1}" var="employeeSkill">
            <tr>
                <td>${employeeSkill.skill.skillName}</td>
                <td>${employeeSkill.servicePrice}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <tr>
        <td>
            <div class="control-group">
                <label class="control-label">基础服务结算方式：</label>
                <input type="radio"  name="sttleStatus"  value="1" <c:if test="${entry.sttleStatus == 1}">checked</c:if>/> 按商品结算价结算
                <input type="radio"  name="sttleStatus"  value="0" <c:if test="${entry.sttleStatus == 0}">checked</c:if>/> 按星级日薪结算
            </div>
        </td>
    </tr>

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
</form:form>
</body>
</html>