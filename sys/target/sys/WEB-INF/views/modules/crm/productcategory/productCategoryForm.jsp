<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>技能项管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/crm/productCategory/list">商品分类列表</a></li>
		<li class="active"><a href="${ctx}/crm/productCategory/form?id=${productCategory.id}">商品分类<shiro:hasPermission name="crm:productCategory:form">${not empty productCategory.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="crm:productCategory:form">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="productCategory" action="${ctx}/crm/productCategory/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级类型名称：</label>
			<div class="controls">
				<sys:treeselect id="productCategory" name="parent.id" value="${productCategory.parent.id}"
								labelName="parent.name" labelValue="${productCategory.parent.name}"
								title="类型名称" url="/crm/productCategory/treeData"
								extId="${productCategory.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">商品分类名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="20" class="required " style="width: 200px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="20" class="required input-xlarge digits " style="width: 200px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图片：</label>
			<div class="controls">
				<form:hidden path="url" id="url"/>
				<span id="coverShow">
					<c:if test="${!empty productCategory.url}">
						<div><img src='${productCategory.url}&iopcmd=thumbnail&type=4&width=100'/></div>
					</c:if>
				</span>
				<span id="uploadCover"></span>
				<div type="button" class="btn" id="deleteCover">删除封面</div>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remark" htmlEscape="false" rows="4" maxlength="1024" style="width: 350px"/>
			</div>
		</div>
		<c:if test="${productCategory.id != null }">
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
			<shiro:hasPermission name="crm:productCategory:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript" src="/static/upload/jquery.form.js"></script>
	<script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
	<script type="text/javascript">
        $(document).ready(function(){

            $("#uploadCover").uploadFile({
                url:"/upload/files",
                fileName:"content",
                uploadStr:"上传封面",
                formData: {"dir":"productCategory","isPrivate":false},
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
                    var url = data.urls[0];//记得改上传目录

                    $("#coverShow").empty();
                    $("#coverShow").html("<div><img src='"+url+"&iopcmd=thumbnail&type=4&width=100'/></div>");
                    $("input[name='url']").val(url);

                },
                onError:function(files,data,xhr,pd) {
                    showMessage("error","上传失败");
                }
            });

            $('form').each(function() {
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
        $("#deleteCover").click(function () {
            $("#coverShow").empty();
            $("input[name='url']").val("");
        });

        function showMessage(status,message) {
            $("#contentTable").before('<div id="messageBox" class="alert alert-'+status+'"><button data-dismiss="alert" class="close">×</button>'+message+'</div>');
        }
	</script>
</body>
</html>