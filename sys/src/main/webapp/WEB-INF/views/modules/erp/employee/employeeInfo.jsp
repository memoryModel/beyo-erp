<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>员工列表</title>
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
                }
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/erp/employee/list">员工列表</a></li>
    </ul></div><br/><div>
    <ul class="nav nav-tabs">
        <li class="active"><shiro:hasPermission name="erp:employee:getEmployeeInfo"><a href="${ctx}/erp/employee/getEmployeeInfo?id=${employee.id}">详细信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="erp:employee:getEmployeeExperienceInfo"><a href="${ctx}/erp/employee/getEmployeeExperienceInfo?id=${employee.id}">资历信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="erp:employee:getEmployeeAuthenticationInfo"><a href="${ctx}/erp/employee/getEmployeeAuthenticationInfo?id=${employee.id}">认证信息</a></shiro:hasPermission></li>
        <li><shiro:hasPermission name="erp:employee:getEmployeeTrainInfo"><a href="${ctx}/erp/employee/getEmployeeTrainInfo?id=${employee.id}">培训信息</a></shiro:hasPermission></li>
        <%--<li><a href="#">派工记录</a></li>
        <li><a href="#">投诉退费记录</a></li>--%>
    </ul></div><br/>
    <form:form id="inputForm" modelAttribute="employee" action="${ctx}/erp/employee/getEmployeeInfo" method="post" class="form-horizontal">
    <form:hidden path="id" id="employeeId"/>
    <sys:message content="${message}"/>
    <div class="alert alert-info">基本信息</div>
    <div class="control-group">
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
                            <form:input path="name" htmlEscape="false" maxlength="50" class="input-xlarge " style="width: 210px"   value="${employee.name}" readonly="true"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">电话：</label>
                        <div class="controls">
                            <form:input path="phone" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.phone}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">身份证号：</label>
                        <div class="controls">
                            <form:input path="empCard" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.idcard}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>

            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">星座：</label>
                        <div class="controls">
                            <form:input path="constellation" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.constellation}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>

                <td>
                    <div class="control-group">
                        <label class="control-label">员工出生日期：</label>
                        <div class="controls">
                            <input name="birthTime" type="text" readonly="true" maxlength="20" class="input-medium Wdate " style="width: 210px"
                                   value="<fmt:formatDate value="${employee.birthTime}" pattern="yyyy-MM-dd"/>"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">服务年限：</label>
                        <div class="controls">
                            <form:input path="serviceTime" htmlEscape="false" maxlength="50" class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.serviceTime}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">工种：</label>
                        <div class="controls">
                                <form:checkboxes path="profession" items="${erp:getCommonsTypeList(21)}" itemLabel="commonsName"  readonly="true"  itemValue="id" htmlEscape="false" class="required  "/>
                                <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">是否住宿：</label>
                        <div class="controls">
                            <form:input path="dormStatus" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.dormStatus}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">详细地址：</label>
                        <div class="controls">
                            <form:input path="originalStreet" htmlEscape="false"  maxlength="1024" class="input-xlarge " style="width: 210px"  readonly="true" />
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
                            <form:input path="emergencyContact" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">紧急联系电话：</label>
                        <div class="controls">
                            <form:input path="emergencyContactPhone" htmlEscape="false" maxlength="50" class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.emergencyContactPhone}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">服务城市：</label>
                        <div class="controls">
                            <form:input path="serveCity" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.serveCity}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">血型：</label>
                        <div class="controls">
                            <form:input path="blood" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.blood}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">年龄：</label>
                        <div class="controls">
                            <form:input path="age" htmlEscape="false" maxlength="50" class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.age}" />
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">座右铭：</label>
                        <div class="controls">
                            <form:input path="motto" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.motto}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">爱好：</label>
                        <div class="controls">
                            <form:input path="hobby" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true" value="${employee.hobby}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">最高学历：</label>
                        <div class="controls">
                            <form:input path="education" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${entry.employee.highestEducation.commonsName}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">外语种类：</label>
                        <div class="controls">
                            <form:input path="language" htmlEscape="false" maxlength="50"  class="input-xlarge " style="width: 210px"  readonly="true"  value="${employee.language}"/>
                            <span class="help-inline"><font color="red">*</font> </span>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">外语等级：</label>
                        <div class="controls">
                            <form:input path="englishLevel.id" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${entry.employee.englishLevel.commonsName}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">籍贯：</label>
                        <div class="controls">
                            <form:input path="originalArea.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${entry.employee.originalArea.name}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">婚姻状态：</label>
                        <div class="controls">
                            <form:input path="maritalStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:210px;" value="${erp:marriageStatusName(entry.employee.maritalStatus)}"/>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label">来源：</label>
                        <div class="controls">
                            <form:input path="customerResource.id" htmlEscape="false" maxlength="50" class="input-large " style="width:210px;" readonly="true" value="${entry.employee.customerResource.customerName}"/>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="control-group">
                        <label class="control-label">民族：</label>
                        <div class="controls">
                            <form:input path="nation.id" htmlEscape="false" maxlength="20" class="input-large" style="width:210px;" readonly="true" value="${entry.employee.nation.commonsName}"/>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>

        <div class="alert alert-info">合同信息</div>
        <div class="control-group">
            <label class="control-label">合同编号：</label>
            <div class="controls">
                <form:input path="entry.code" htmlEscape="false" maxlength="50" readonly="true" value="${employee.entry.code}" class="input-xlarge " style="width: 180px"/>
            </div>
        </div>
            <div class="alert alert-info">财务信息</div>
            <div class="control-group">
                <table  class="table table-striped table-bordered table-condensed" style="width:95%;">
                    <tr>
                        <td>
                            <label class="control-label">有无欠款：</label>
                            <div class="controls">
                                <form:input path="entry.debtStatus" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${erp:debtStatusName(employee.entry.debtStatus)}"/>
                            </div>
                        </td>
                        <td>
                            <label class="control-label">底薪(元): </label>
                            <div class="controls">
                                <form:input path="entry.pay" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.pay}"/>
                            </div>
                        </td>
                        <td>
                            <label class="control-label">工资卡号1: </label>
                            <div class="controls">
                                <form:input path="entry.idCard" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.idCard}"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="control-label">所属银行1: </label>
                            <div class="controls">
                                <form:input path="entry.bank" htmlEscape="false" maxlength="50" class="input-large " readonly="true"  style="width:150px;" value="${employee.entry.bank}"/>
                            </div>
                        </td>
                        <td>
                            <label class="control-label">工资卡号2: </label>
                            <div class="controls">
                                <form:input path="entry.idCarda" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.idCarda}"/>
                            </div>
                        </td>
                        <td>
                            <label class="control-label">所属银行2: </label>
                            <div class="controls">
                                <form:input path="entry.banka" htmlEscape="false" maxlength="50" class="input-large " readonly="true" style="width:150px;" value="${employee.entry.banka}"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        <div class="alert alert-info">员工等级</div>
            <table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width:95%;">
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
        <table id="contentTable" class="table table-striped table-bordered table-condensed" style="width:90%;">
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
            <table  id="contentTable" class="table table-striped table-bordered table-condensed" style="width:95%;">
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
                        <td><img src='${employeeInfo.url}@100w_100h'/></td>
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
                        <td><img src='${employeeInfo.url}@100w_100h'/></td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>
        </table>
    </form:form>
</body>
</html>