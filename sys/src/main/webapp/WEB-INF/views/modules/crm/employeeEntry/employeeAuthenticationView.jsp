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
        <li ><a href="${ctx}/crm/employeeEntry/info?id=${entryId}" >详细信息</a></li>
        <li><a href="${ctx}/erp/employeeResume/view?employeeId=${employeeInfo.employee.id}&entryId=${entryId}">资历信息</a></li>
        <li class="active"><a href="${ctx}/erp/employeeInfo/view?employeeId=${employeeInfo.employee.id}&entryId=${entryId}" >认证信息</a></li>

    </ul>
    <form:form id="inputForm" modelAttribute="employeeInfo" action="${ctx}/erp/employeeInfo/save" method="post" class="form-horizontal">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>

        <div class="control-group">
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