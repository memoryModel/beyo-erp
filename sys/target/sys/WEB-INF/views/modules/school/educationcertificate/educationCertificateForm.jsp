<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>证书设置管理</title>
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
	<li><a href="${ctx}/school/educationCertificate/list">证书设置列表</a></li>
	<li class="active"><a href="${ctx}/school/educationCertificate/form?id=${educationCertificate.id}">证书设置<shiro:hasPermission name="school:educationCertificate:form">${not empty educationCertificate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="school:educationCertificate:form">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="educationCertificate" action="${ctx}/school/educationCertificate/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label">名称：</label>
		<div class="controls">
			<form:input path="certificateName" htmlEscape="false" maxlength="64" class="required input-xlarge " style="width: 200px"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">描述：</label>
		<div class="controls">
			<form:textarea path="description" htmlEscape="false" rows="4" maxlength="1024" class="input-xlarge " style="width: 350px"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">商品封面：</label>
		<div class="controls">
			<form:hidden path="photoUrl" id="photoUrl"/><!--表对象对应字段-->
			<span id="coverShow">
				 <c:if test="${!empty educationCertificate.photoUrl}">
					<div>
					 <img src='${educationCertificate.photoUrl}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
					</div>
				 </c:if>
            </span>
			<span id="uploadCover"></span>
			<div type="button" class="btn" id="deleteCover">删除封面</div>
		</div>
	</div>
	<c:if test="${educationCertificate.id != null }">
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-large ">
					<form:options items="${erp:commonsStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
	</c:if>
	<div class="form-actions">
		<shiro:hasPermission name="school:educationCertificate:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">
    $(document).ready(function(){
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
                $("input[name='photoUrl']").val(url);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });
    });

    $("#deleteCover").click(function () {
        $("#coverShow").empty();
        $("input[name='photoUrl']").val("");
    });
</script>
</body>
</html>