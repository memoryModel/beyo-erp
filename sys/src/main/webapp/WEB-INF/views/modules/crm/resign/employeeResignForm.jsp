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


        //选中完善信息则展示
        $(document).ready(function(){
            $("#ssss").hide()
            $("#checkbox").click(function(){
                $("form1").toggle();
            });
        });
    </script>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/employeeResign/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
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
							<form:select path="type" class="input-large" disabled="true" >
								<form:options items="${erp:employeeTypeList()}" itemLabel="name" itemValue="value"  htmlEscape="false" />
							</form:select>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">有无底薪：</label>
						<div class="controls">
							<form:select path="basePayStatus" class="input-large" disabled="true">
								<form:options items="${erp:basePayStatusList()}" itemLabel="name" itemValue="value"  htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
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
								<input name="takeTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
									   value="<fmt:formatDate value="${entry.takeTime}" pattern="yyyy-MM-dd HH:mm"/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							</div>
							<span class="help-inline"><font color="red">*</font> </span>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">签约截止时间：</label>
						<div class="controls">
							<input name="deadlineTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
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
							<input name="entryTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
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
							<input name="workTime" disabled="disabled" type="text" maxlength="20" readonly="true" class="required input-medium Wdate checkTime" style="width: 205px;"
								   value="<fmt:formatDate value="${entry.workTime}" pattern="yyyy-MM-dd HH:mm"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<table id="table">
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
						<label class="control-label"> </label>
						<div class="controls">
							<input id="selectItems" class="btn btn-primary" type="button" value="添加一项可服务范围"  onclick="add()"/>
						</div>
					</div>
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label">可服务时间：</label>
						<div class="controls">
							<c:if test="${not empty entry.serviceTime}">
								<form:checkboxes path="serviceTimeList" items="${erp:getCommonsTypeList(53)}" itemLabel="commonsName" itemValue="id" htmlEscape="false" class="required"/>
							</c:if>
							<c:if test="${empty entry.serviceTime}">
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
							<form:input path="bankName" htmlEscape="false" maxlength="50" class="required input-large " />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">卡号：</label>
						<div class="controls">
							<form:input path="bankNumber" htmlEscape="false" maxlength="50" class="required input-large " />
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
							<form:input path="secondBankName" htmlEscape="false" maxlength="50" class="required input-large " />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label">卡号：</label>
						<div class="controls">
							<form:input path="secondBankNumber" htmlEscape="false" maxlength="50" class="required input-large " />
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>

	<div class="alert alert-info">认证信息</div>

		<div class="control-group">
			<table>
				<tr>
				<td>
					<div class="control-group">
						<label class="control-label">类型：</label>
						<div class="controls">
							<form:select path="employeeInfoTypeFirst" class="input-large ">
								<form:options items="${erp:employeeInfoTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
							</form:select>
							<span class="help-inline"><font color="red">*</font> </span>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<div class="controls">
							<form:hidden path="employeeInfoUrlFirst" id="url"/><!--表对象对应字段-->
							<span id="coverShowFirst">
								 <c:if test="${!empty entry.employeeInfoUrlFirst}">
									<div>
									 <img src='${entry.employeeInfoUrlFirst}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
									</div>
								 </c:if>
								</span>
							<span id="uploadCoverFirst"></span>
							<div type="button" class="btn" id="deleteCoverFirst">删除身份证正面</div>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<div class="controls">
							<form:hidden path="employeeInfoUrlSecond" id="url"/><!--表对象对应字段-->
							<span id="coverShowSecond">
								 <c:if test="${!empty entry.employeeInfoUrlSecond}">
									<div>
									 <img src='${entry.employeeInfoUrlSecond}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
									</div>
								 </c:if>
								</span>
							<span id="uploadCoverSecond"></span>
							<div type="button" class="btn" id="deleteCoverSecond">删除身份证反面</div>
						</div>
					</div>
				</td>
			</tr>
				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">类型：</label>
							<div class="controls">
								<form:select path="employeeInfoTypeSecond" class="input-large ">
									<form:options items="${erp:employeeInfoTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<div class="controls">
								<form:hidden path="employeeInfoUrlThird" id="url"/><!--表对象对应字段-->
								<span id="coverShowThird">
								 <c:if test="${!empty entry.employeeInfoUrlThird}">
									<div>
									 <img src='${entry.employeeInfoUrlThird}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
									</div>
								 </c:if>
								</span>
								<span id="uploadCoverThird"></span>
								<div type="button" class="btn" id="deleteCoverThird">删除健康证</div>
							</div>
						</div>
					</td>
				</tr>

				<tr>
					<td>
						<div class="control-group">
							<label class="control-label">类型：</label>
							<div class="controls">
								<form:select path="employeeInfoTypeThird" class="input-large ">
									<form:options items="${erp:employeeInfoTypeList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
								</form:select>
								<span class="help-inline"><font color="red">*</font> </span>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<div class="controls">
								<form:hidden path="employeeInfoUrlFourth" id="url"/><!--表对象对应字段-->
								<span id="coverShowFourth">
								 <c:if test="${!empty entry.employeeInfoUrlFourth}">
									<div>
									 <img src='${entry.employeeInfoUrlFourth}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
									</div>
								 </c:if>
								</span>
								<span id="uploadCoverFourth"></span>
								<div type="button" class="btn" id="deleteCoverFourth">删除职业资格证</div>
							</div>
						</div>
					</td>
					<td>
						<div class="control-group">
							<div class="controls">
								<form:hidden path="employeeInfoUrlFifth" id="url"/><!--表对象对应字段-->
								<span id="coverShowFifth">
								 <c:if test="${!empty entry.employeeInfoUrlFifth}">
									<div>
									 <img src='${entry.employeeInfoUrlFifth}&iopcmd=thumbnail&type=4&width=100'/><!--如果是图片，展示-->
									</div>
								 </c:if>
								</span>
								<span id="uploadCoverFifth"></span>
								<div type="button" class="btn" id="deleteCoverFifth">删除职业资格证</div>
							</div>
						</div>
					</td>
				</tr>
			</table>

	<input type="checkbox"  id="checkbox">其他信息完善
			<form1 id ="ssss">

				<li ><shiro:hasPermission name="crm:entry:info"><a href="${ctx}/crm/entry/info?id=${entryId}">详细信息</a></shiro:hasPermission></li>
				<li><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/experienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">资历信息</a></shiro:hasPermission></li>
				<li><shiro:hasPermission name="erp:employeeResume:experienceInfo"><a href="${ctx}/erp/employeeResume/experienceInfo?employeeId=${employeeResume.employee.id}&entryId=${entryId}">培训信息</a></shiro:hasPermission></li>


				<table>
					<tr>
						<td>
							<div class="control-group">
								<label class="control-label">性别：</label>
								<div class="controls">
									<form:select path="employee.sex"  class="required input-large ">
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:sexStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
									</form:select>
									<span class="help-inline"><font color="red">*</font> </span>
								</div>
							</div>
						</td>
						<td>
							<div class="control-group">
								<label class="control-label">出生日期：</label>
								<div class="controls">
									<input  name="birthTime" type="text" class="input-medium Wdate "
											value="<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd"/>"
											onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
								</div>
							</div>
						</td>
						<td>
							<div class="control-group">
								<label class="control-label">身份证号：</label>
								<div class="controls">
									<form:input path="employee.idcard" htmlEscape="false" maxlength="128" class="required card empCardExist valid" />
									<span class="help-inline"><font color="red">*</font> </span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="control-group">
								<label class="control-label">民族：</label>
								<div class="controls">
									<form:select path="employee.nation" class="input-large" >
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:getCommonsTypeList(43)}" readonly="true" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</td>
						<td>
							<div class="control-group">
								<label class="control-label">学历：</label>
								<div class="controls">
									<form:select path="employee.education" class="input-large" >
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:getCommonsTypeList(7)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</td>
						<td>
							<div class="control-group">
								<label class="control-label">婚姻状况：</label>
								<div class="controls">
									<form:select path="employee.marriage" class="input-large " >
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:marriageStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="control-group">
								<label class="control-label">星座：</label>
								<div class="controls">
									<form:select path="employee.constellation" class="input-large" >
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:getCommonsTypeList(56)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</td>
						<td>
							<div class="control-group">
								<label class="control-label">血型：</label>
								<div class="controls">
									<form:select path="employee.blood" class="input-large" >
										<form:option value="" label="------请选择------"/>
										<form:options items="${erp:getCommonsTypeList(57)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
									</form:select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="control-group">
								<label class="control-label">籍贯：</label>
								<div class="controls">
									<sys:treeselect id="area" name="originalArea.id" value="${entry.employee.originalArea.id}"
													labelName="originalArea.name" labelValue="${entry.employee.originalArea.name}"
													title="区域" url="/sys/area/treeData" />
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
									<form:textarea path="employee.originalStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" />
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="control-group">
								<label class="control-label">现居住地：</label>
								<div class="controls">
									<sys:treeselect id="area1" name="currentArea.id" value="${entry.employee.currentArea.id}"
													labelName="currentArea.name" labelValue="${entry.employee.currentArea.name}"
													title="区域" url="/sys/area/treeData"/>
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
									<form:textarea path="employee.currentStreet" htmlEscape="false" rows="1" style="width:700px;" maxlength="1024" />
								</div>
							</div>
						</td>
					</tr>
				</table>
			</form1>

	<div class="form-actions">
		<shiro:hasPermission name="crm:employeeResign:getEmployeeInfo"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交签约审批"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
    <input type="hidden" name="hdWeightListSize" value="${weightListSize}">
</form:form>

<script type="text/javascript">
    $(document).ready(function() {
        $("#uploadCoverFirst").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传身份证正面",//按钮名称
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

                var urlFirst = data.urls[0];

                $("#coverShowFirst").empty();
                $("#coverShowFirst").html("<div><img src='"+urlFirst+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                $("input[name='employeeInfoUrlFirst']").val(urlFirst);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

        $("#uploadCoverSecond").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传身份证反面",//按钮名称
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

                var urlSecond = data.urls[0];

                $("#coverShowSecond").empty();
                $("#coverShowSecond").html("<div><img src='"+urlSecond+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                $("input[name='employeeInfoUrlSecond']").val(urlSecond);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

        $("#uploadCoverThird").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传健康证",//按钮名称
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

                var urlThird = data.urls[0];

                $("#coverShowThird").empty();
                $("#coverShowThird").html("<div><img src='"+urlThird+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                $("input[name='employeeInfoUrlThird']").val(urlThird);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

        $("#uploadCoverFourth").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传职业资格证",//按钮名称
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

                var urlFourth = data.urls[0];

                $("#coverShowFourth").empty();
                $("#coverShowFourth").html("<div><img src='"+urlFourth+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                $("input[name='employeeInfoUrlFourth']").val(urlFourth);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

        $("#uploadCoverFifth").uploadFile({
            url:"/upload/files",
            fileName:"content",
            uploadStr:"上传职业资格证",//按钮名称
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

                var urlFifth = data.urls[0];

                $("#coverShowFifth").empty();
                $("#coverShowFifth").html("<div><img src='"+urlFifth+"&iopcmd=thumbnail&type=4&width=100'/></div>");<!--如果是图片-->
                $("input[name='employeeInfoUrlFifth']").val(urlFifth);

            },
            onError:function(files,data,xhr,pd) {
                showMessage("error","上传失败");
            }
        });

    });

    $("#deleteCoverFirst").click(function () {
        $("#coverShowFirst").empty();
        $("input[name='employeeInfoUrlFirst']").val("");
    });

    $("#deleteCoverSecond").click(function () {
        $("#coverShowSecond").empty();
        $("input[name='employeeInfoUrlSecond']").val("");
    });

    $("#deleteCoverThird").click(function () {
        $("#coverShowThird").empty();
        $("input[name='employeeInfoUrlThird']").val("");
    });

    $("#deleteCoverFourth").click(function () {
        $("#coverShowFourth").empty();
        $("input[name='employeeInfoUrlFourth']").val("");
    });

    $("#deleteCoverFifth").click(function () {
        $("#coverShowFifth").empty();
        $("input[name='employeeInfoUrlFifth']").val("");
    });


    //添加可服务范围
    function add(){
        var element = $("#table").find("tr:first");
        var amountHtml = $('#hdAmoutHTML').html();
        if(amountHtml == null || amountHtml == '' ||"undefined" == typeof amountHtml){
            $('#table').append($(element).clone(true));
        }else{
            $('#table').append(amountHtml);
        }
    }

</script>

</body>
</html>