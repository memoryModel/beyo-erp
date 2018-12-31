<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>入职签约管理</title>
    <meta name="decorator" content="default"/>
    <link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="/static/upload/jquery.form.js"></script>
    <script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").each(function() {
                $(this).validate({
                    ignore: ".ignore",
                    submitHandler: function (form) {
                        loading('正在提交，请稍等...');
                        form.submit();
                    },
                    errorContainer: "#messageBox",
                    errorPlacement: function (error, element) {
                        $("#messageBox").text("输入有误，请先更正。");
                        if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                            error.appendTo(element.parent().parent());
                        } else {
                            error.insertAfter(element);
                        }
                    }
                });
            });
        });
    </script>
</head>
<body>

    <ul class="nav nav-tabs">
<%--
        <li><a href="${ctx}/crm/entry/list">入职签约管理</a></li>
--%>
        <li ><a href="${ctx}/crm/entry/form?id=${entryId}">详细信息</a></li>
        <li><a href="${ctx}/erp/employeeResume/experienceInfo?employeeId=${employeeInfo.employee.id}&entryId=${entryId}">资历信息</a></li>
        <li class="active"><a href="${ctx}/erp/employeeInfo/getEmployeeExperienceInfo?employeeId=${employeeInfo.employee.id}&entryId=${entryId}" >培训信息</a></li>

    </ul>
    <form:form id="inputForm" modelAttribute="employeeInfo" action="${ctx}/erp/employeeInfo/save" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>
        <div class="control-group" >
            <div class="controls">
                <%--<form:input path="employee.id" id="employeeId" value="${employeeId}" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>--%>
                <form:hidden path="employee.id" id="employeeId" value="${employeeId}" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">名称：</label>
            <div class="controls">
                <form:input path="name" htmlEscape="false" maxlength="180" class="required input-xlarge" style="width: 200px"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">类型：</label>
            <div class="controls">
                <form:select path="type" class="input-large ">
                    <form:options items="${erp:employeeInfoTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
                </form:select>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">图片：</label>
            <div class="controls">
                <form:hidden path="url" id="url"/><!--表对象对应字段-->
                <span id="coverShow">
                 <c:if test="${!empty employeeInfo.url}">
                    <div>
                     <img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
                    </div>
                 </c:if>
                </span>
                <span id="uploadCover"></span>
                <div type="button" class="btn" id="deleteCover">删除封面</div>
            </div>
        </div>
        <div class="form-actions">
            <shiro:hasPermission name="erp:employeeInfo:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
        </div>
        <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">证件：</label>
            <div class="controls">
                <table id="contentTable2" class="table table-striped table-bordered table-condensed" style="width: 60%">
                    <thead>
                    <tr>
                        <th>名称</th>
                        <th>类型</th>
                        <th>图片</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${employeeInfoList}" var="employeeInfo">
                        <tr>
                            <td>
                                    ${employeeInfo.name}
                            </td>
                            <td>
                                    ${erp:employeeInfoTypeName(employeeInfo.type)}
                            </td>
                            <td>
                                <img src='${employeeInfo.url}&iopcmd=thumbnail&type=4&width=100'/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        </form:form>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#uploadCover").uploadFile({
                url:"/upload/files",
                fileName:"content",
                uploadStr:"上传封面",//按钮名称
                formData: {"dir":"product","isPrivate":false},//上传目录，按产品功能命名
                multiple:false,
                dragDrop:false,
                uploadButtonClass:"ajax-file-upload-green btn btn-primary ignore",
                showStatusAfterSuccess:false,
                showAbort:false,
                showDone:false,
                acceptFiles:"image/*",
                allowedTypes:"png,gif,jpg,jpeg",
                returnType:"json",
                showPreview:true,
                previewHeight: "100px",
                previewWidth: "100px",
                onSuccess:function(files,data,xhr,pd) {

                    var url = data.urls[0];

                    $("#coverShow").empty();
                    $("#coverShow").html("<div><img src='"+url+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                    $("input[name='url']").val(url);

                },
                onError:function(files,data,xhr,pd) {
                    showMessage("error","上传失败");
                }
            });

        });
        $("#deleteCover").click(function () {
            $("#coverShow").empty();
            $("input[name='url']").val("");
        });
    </script>
</body>
</html>