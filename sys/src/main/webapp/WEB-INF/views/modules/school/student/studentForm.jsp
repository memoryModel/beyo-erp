<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>单表管理</title>
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
                    if (element.is(":checkbox")||element.is(":radio")){
                        error.appendTo(element.parent().parent());
                    }else if(element.parent().is(".input-append")){
                        $(error).text("必填信息");
                        element.parents(".controls").append(error);
                    }else {
                        error.insertAfter(element);
                    }
                }
            });

            //验证手机号是否存在
            jQuery.validator.addMethod("phoneExist", function (value, element) {

                //修改时若手机号没改变则跳过验证
                if(value == $("#phone").val()){
                    return true;
                }
                var flag = false;
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "/school/student/ifPhone",
                    data: "graphone=" + value,
                    success: function (data) {
                        console.log(data);
                        if (data == "success") {
                            flag = true;
                        } else {
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "手机号码已存在");


            //验证身份证号码是否存在
            jQuery.validator.addMethod("stuNumberExist", function (value, element) {

                //修改时若身份证号码未改动，跳过验证
                if(value == $("#stuNumber").val()){
                    return true;
                }
                var flag = false;
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "/school/student/ifStuNumber",
                    data: "graStuNumber=" + value,
                    success: function (data) {
                        if (data == "success") {
                            var idNumberTime = value.toString().substring(6,10)+'-'+value.toString().substring(10,12)+'-'+value.toString().substring(12,14);
                            $('[name="dateBirth"]').val(idNumberTime);
                            var birthDay = $('[name="dateBirth"]').val();
                            var age = ages(birthDay);
                            $('#ageSpanId').text(age);

                            flag = true;
                        } else {
                            flag = false;
                        }
                    }
                });
                return flag;
            }, "身份证号码已存在");

            if(${not empty student.id}){
                var occupationList = ${student.getOccupationList()};
            }

            //添加生源默认是女
            var sexFlag = '${sexFlag}';
            var sex = '${student.sex}';
            if (sexFlag != null){
                $('#radio2').attr("checked",true);
            }
            if (sex == 1){
                $('#radio1').attr("checked",true);
            }else if(sex == 2){
                $('#radio2').attr("checked",true);
            }

            //进入页面默认性别为女
            var allBox = $(":radio");
            allBox.click(function () {
                if(this.checked){
                    allBox.removeAttr("checked");
                    $(this).attr("checked", "checked");
                }
            });

            $('[name="followId"]').click(function(){
                var follow = $('[name="followId"]');
                var userId = $('#userId').val();
                if (follow.is(':checked')){
                    $('[name="followId"]').val(userId);
                }
            })
        });

        //根据出生日期得到年龄
        function ages(birthDay){
            var   r   =   birthDay.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
            if(r==null)return   false;
            var   d=   new   Date(r[1],   r[3]-1,   r[4]);
            if   (d.getFullYear()==r[1]&&(d.getMonth()+1)==r[3]&&d.getDate()==r[4]) {
                var   Y   =   new   Date().getFullYear();
                return("年龄   =   "+   (Y-r[1])   +"   周岁");
            }
            return("输入的日期格式错误！");
        }

        //根据出生日期得到年龄
        function checkAge(){
            var birthDay = $('#dateBirthId').val();
            var age = ages(birthDay);
            $('#ageSpanId').text(age);
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <shiro:hasPermission name="school:student:list">
        <li id="li0"><a href="${ctx}/school/student/list">全部生源</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="school:student:followNoList">
        <li id="li1"><a href="${ctx}/school/student/followNoList">未分配生源</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="school:student:followList">
        <li id="li2"><a href="${ctx}/school/student/followList">已分配生源</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="school:student:mineStudentList">
        <li id="li3"><a href="${ctx}/school/student/mineStudentList">我的生源</a></li>
    </shiro:hasPermission>
    <shiro:hasPermission name="school:student:saveForm">
        <li class="active"><a href="${ctx}/school/student/saveForm?id=${student.id}"><shiro:hasPermission name="school:student:form">${not empty student.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:student:form"></shiro:lacksPermission>生源</a></li>
    </shiro:hasPermission>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="student" action="${ctx}/school/student/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <input type="hidden" value="${student.phone}" id="phone">
    <input type="hidden" value="${student.stuNumber}" id="stuNumber">
    <inout type="hidden" name="sex"></inout>
    <input type="hidden" id="studentId" value="${student.id}">
    <table style="border-collapse:separate; border-spacing:5px;">
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">名称：</label>
                    <div class="controls">
                        <form:input path="name"  htmlEscape="false" class="required input-xlarge"  maxlength="64" style="width: 210px"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">身份证号：</label>
                    <div class="controls">
                        <form:input path="stuNumber" htmlEscape="false"  class="card stuNumberExist valid" style="width: 210px"/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">身份证地址：</label>
                    <div class="controls">
                        <form:input path="stuNumberAddress" htmlEscape="false"  class="" style="width: 210px"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">出生日期：</label>
                    <div class="controls">
                        <input name="dateBirth" onchange="checkAge()" id="dateBirthId" type="text" readonly="readonly" style="width: 210px" class="input-medium Wdate "
                               value="<fmt:formatDate value="${student.dateBirth}" pattern="yyyy-MM-dd"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <span id="ageSpanId"></span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">职业方向：</label>
                    <div class="controls">
                        <c:if test="${not empty student.id}">
                            <form:checkboxes path="occupationList" items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                        </c:if>
                        <c:if test="${empty student.id}">
                            <form:checkboxes path="occupationId" items="${erp:getCommonsTypeList(12)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
                        </c:if>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">手机号码：</label>
                    <div class="controls">
                        <form:input path="phone" maxlength="11" htmlEscape="false"  class="required mobile phoneExist valid" style="width: 210px"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联系人：</label>
                    <div class="controls">
                        <form:input path="emergencyContact" htmlEscape="false"  class="input-xlarge" style="width: 210px"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">QQ号码：</label>
                    <div class="controls">
                        <form:input path="qqNumber" htmlEscape="false"  class="qq valid" style="width: 210px"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">紧急联络人电话：</label>
                    <div class="controls">
                        <form:input path="urgencyPhone" htmlEscape="false"  class="simplePhone valid " style="width: 210px"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">生活城市:</label>
                    <div class="controls">
                        <sys:treeselect id="stuCity" name="stuCity.id" value="${student.stuCity.id}"
                                        labelName="stuCity.name" labelValue="${student.stuCity.name}"
                                        title="区域" url="/sys/area/treeData" />
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <input type="radio" name="sex" id="radio1" value="1"/>男
                        <input type="radio" name="sex" id="radio2" value="2"/>女
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">籍贯:</label>
                    <div class="controls">
                        <sys:treeselect id="nativePlace" name="nativePlace.id" value="${student.nativePlace.id}"
                                        labelName="nativePlace.name" labelValue="${student.nativePlace.name}"
                                        title="区域" url="/sys/area/treeData" />
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">学历：</label>
                    <div class="controls">
                        <form:select path="education" class="input-xlarge" style="width: 220px">
                            <form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">招生来源：</label>
                    <div class="controls" >
                        <sys:treeselect id="customerResource"  name="customerResource.id" value="${student.customerResource.id}"
                                        labelName="student.customerResource.customerName" labelValue="${student.customerResource.customerName}"
                                        title="来源名称" url="/erp/customerResource/treeData" cssClass="required valid" />
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">所属校区:</label>
                    <div class="controls">
                        <form:select path="areas.id" class="required" style="width: 220px">
                            <form:options items="${areasList}" itemLabel="areaName" class="required" itemValue="id" htmlEscape="false"/>
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">招聘老师：</label>
                    <div class="controls">
                        <sys:treeselect id="teacher" name="teacher.id" value="${student.teacher.id}"
                                        labelName="teacher.name" labelValue="${student.teacher.name}"
                                        title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">学员类型：</label>
                    <div class="controls">
                        <form:select path="studentType" class="required" style="width: 220px">
                            <form:options items="${erp:StudentTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false" />
                        </form:select>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">推荐人：</label>
                    <div class="controls">
                        <sys:treeselect id="referrer" name="referrer.id" value="${student.referrer.id}"
                                        labelName="student.referrer.name" labelValue="${student.referrer.name}"
                                        title="推荐人" url="/sys/office/treeData?type=3" allowClear="true" notAllowSelectParent="true"/>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">预计报名时间：</label>
                    <div class="controls">
                        <input  name="predictApplyTime" type="text" readonly="readonly" style="width: 210px" class="input-medium Wdate "
                                value="<fmt:formatDate value="${student.predictApplyTime}" pattern="yyyy-MM-dd"/>"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">添加人：</label>
                    <div class="controls">
                        <input type="hidden" id="userId" value="${student.user.id}" />
                        <sys:treeselect id="user" name="user.id" value="${student.user.id}"
                                        labelName="user.name" labelValue="${student.user.name}"
                                        title="选择用户" url="/sys/office/treeData?type=3" cssClass="required" notAllowSelectParent="true"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                    </div>
                </div>
            </td>
            <td>
                <div class="control-group">
                    <label class="control-label">添加时间：</label>
                    <div class="controls">
                        <input name="createTime" type="text" readonly="readonly" style="width: 210px" class=" required input-medium Wdate "
                               value="<fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="control-group">
                    <label class="control-label">备注：</label>
                    <div class="controls">
                        <form:textarea path="remark" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge"/>
                    </div>
                </div>
            </td>
        </tr>
        <c:if test="${empty student.id}">
            <tr>
                <td>
                    <div class="control-group">
                        <label class="control-label"><input type="checkbox" name="followId"></label>
                        <div class="controls">
                            委派自己为跟进人
                        </div>
                    </div>
                </td>
            </tr>
        </c:if>

    </table>
    <div class="form-actions">
        <shiro:hasPermission name="school:student:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>


