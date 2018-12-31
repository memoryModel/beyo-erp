<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工入职管理</title>
	<meta name="decorator" content="default"/>
	<link href="/static/upload/uploadfile.css?v=1" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="/static/upload/jquery.form.js"></script>
	<script type="text/javascript" src="/static/upload/jquery.uploadfile.min.js?v=1"></script>
    <script type="text/javascript">
        var array = new Array();
    </script>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/employeeResign/approveSave" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
	<input type="hidden" name="entry.approveStatus" value="${entry.approveStatus}">
	<sys:message content="${message}"/>
	<div class="alert alert-info">办理入职</div>
	<div class="control-group">
	</div>
	<table class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>姓名</th>
			<th>性别</th>
			<th>手机号码</th>
			<th>工种</th>
			<th>来源</th>
			<th>出生日期</th>
		</tr>
		</thead>
		<tr>
			<td>
					${entry.employee.name}
			</td>
			<td>
					${erp:sexStatusName(entry.employee.sex)}
			</td>
			<td>
					${entry.employee.phone}
			</td>
			<td>
				<c:forEach items="${entry.employee.getProfessionList()}" var="occId" varStatus="length">
					<c:if test="${length.index!=0}">
						,
					</c:if>
					${erp:getCommonsTypeName(occId)}
				</c:forEach>
			</td>
			<td>
					${entry.employee.customerResource.customerName}
			</td>
			<td>
				<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>
			</td>
		</tr>

	</table>

	<div class="alert alert-info">员工定级和技能项信息</div>
	基础服务技能定级
	<div class="control-group">
	</div>
	<div class="control-group">
		<table class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>基础服务技能</th>
				<c:forEach items="${weightList}" var="weight" varStatus="index">
					<th>${weight.checkName}得分</th>
				</c:forEach>
				<th>综合得分</th>
				<th>系统测评定级</th>
				<th>人工定级</th>
				<th>员工服务结算单价</th>
			</tr>
			</thead>
			<tbody tbodyName="besicSkill">
			<c:forEach items="${besicSkillList}" var="besicSkill">
				<tr>
					<td>
							${besicSkill.skill.skillName}
					</td>
					<c:forEach items="${besicSkill.skillWeightList}" var="skillWeight">
						<td>
								${skillWeight.weightScore}
						</td>
					</c:forEach>
					<td>
							${besicSkill.score}
					</td>
					<td>
							${besicSkill.systemServiceLevel.name}
					</td>
					<td>
							${besicSkill.serviceLevel.name}
					</td>
					<td>
							${besicSkill.servicePrice}元/${erp:unitStatusName(besicSkill.skill.unit)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>


	<div class="control-group">
		员工服务技能
	</div>
	<div class="control-group">
		<table  id="skillContentTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<th>技能项名称</th>
				<th>计价单位</th>
				<th>类型</th>
				<th>服务结算单价</th>
			</tr>
			</thead>
			<tbody tbodyName="singleSkill">
			<c:forEach items="${singleSkillList}" var="singleSkill">
				<tr>
					<td>
							${singleSkill.skill.skillName}
					</td>
					<td>
							${erp:unitStatusName(singleSkill.skill.unit)}
					</td>
					<td>
						单项服务
					</td>
					<td>
							${singleSkill.servicePrice}元/${erp:unitStatusName(singleSkill.skill.unit)}
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="contentTable" class="alert alert-info">薪资结构</div>

	<div class="control-group">
		<table>
			<tr>
				<td colspan="2">
					<div class="control-group">
						<label class="control-label">员工性质：</label>
						<div class="controls">
							<input type="radio"  name="type"  value="1" checked="checked"/>员工制
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;
							<input type="radio"  name="type"  value="0" />劳务制
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无底薪：</label>
						<div class="controls">
							<input type="radio"  name="basePayStatus"  value="1" checked="checked"/>有
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio"  name="basePayStatus"  value="0"  />无
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">签约和上岗信息</div>
	<div class="control-group">
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">合同编号: </label>
						<div class="controls">
								${entry.contractCode}
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">签约生效时间：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								   value="<fmt:formatDate value="${entry.takeTime}" pattern="yyyy-MM-dd HH:mm"/>"
							       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">签约截止时间：</label>
						<div class="controls">
							<input name="birthTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								   value="<fmt:formatDate value="${entry.deadlineTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">入职日期：</label>
						<div class="controls">
							<input name="entryTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								   value="<fmt:formatDate value="${entry.entryTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">可上岗日期：</label>
						<div class="controls">
							<input name="workTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
								   value="<fmt:formatDate value="${entry.workTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">可服务范围：</label>
						<div class="controls">
							<sys:treeselect id="area" name="area.id" value="${entry.area.id}"
											labelName="area.name" labelValue="${entry.area.name}"
											title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true"/>
							<span class="help-inline" style="margin-left: 20px"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">可服务时间：</label>
						<div class="controls">
							<c:if test="${not empty entry.id}">
								<form:checkboxes path="serviceTimeList" items="${erp:getCommonsTypeList(53)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
							</c:if>
							<c:if test="${empty entry.id}">
								<form:checkboxes path="serviceTime" items="${erp:getCommonsTypeList(53)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
							</c:if>
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
							<input type="radio"  name="dormStatus"  value="1" checked="checked"/>是
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio"  name="dormStatus"  value="0"  />否
							<font color="red">*</font>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">银行卡信息</div>
	<div class="control-group">
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">所属银行：</label>
						<div class="controls">
							<form:input path="bankName" htmlEscape="false" maxlength="50" class="required input-large " readonly="true" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">卡号：</label>
						<div class="controls">
							<form:input path="bankNumber" htmlEscape="false" maxlength="50" class="required input-large " readonly="true"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">所属银行：</label>
						<div class="controls">
							<form:input path="secondBankName" htmlEscape="false" maxlength="50" class="required input-large " readonly="true" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">卡号：</label>
						<div class="controls">
							<form:input path="secondBankNumber" htmlEscape="false" maxlength="50" class="required input-large " readonly="true" />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">认证信息</div>

		<div class="control-group">
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
							<th>类型</th>
							<th>图片</th>
						</tr>
						</thead>
						<tbody>
						<c:forEach items="${employeeInfoList}" var="employeeInfo">
							<tr>
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


	<div class="alert alert-info"><center><strong><h4>审批意见</h4></strong></center></div>

			<table>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">审批结果：</label>
							<div class="controls">
								<input type="radio"  name="approveStatus"  value="6" checked="checked"/>审批通过
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio"  name="approveStatus"  value="4"  />退回
								<font color="red">*</font>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="control-group">
							<label class="control-label">审批意见：</label>
							<div class="controls">
								<form:textarea path="entryReason" htmlEscape="false" maxlength="1024" rows="3" style="width:800px;"/>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">签约操作人：</label>
							<div class="controls">
								<form:input path="user.name" htmlEscape="false"  maxlength="1024" class="input-large " readonly="true" value="${createUserName}"/>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<label class="control-label">操作时间：</label>
							<div class="controls">
								<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate " disabled="disabled"
									   value="<fmt:formatDate value="${entry.createTime}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
				</tr>

			</table>

		<shiro:hasPermission name="crm:employeeResign:getEmployeeInfo"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交审批意见"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="取 消" onclick="history.go(-1)"/>
	</div>
    <input type="hidden" name="hdWeightListSize" value="${weightListSize}">
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
                $("input[name='employeeInfo.url']").val(url);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

    });
    $("#deleteCover").click(function () {
        $("#coverShow").empty();
        $("input[name='employeeInfo.url']").val("");
    });

    //保存图片
    function  subPic()
    {
        $("#inputForm").removeAttr('action');
        $("#inputForm").attr('action','${ctx}/crm/employeeResign/savePic');
        $("#inputForm").submit();
    }
</script>

</body>
</html>