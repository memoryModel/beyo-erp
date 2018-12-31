<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工续约管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/crm/employeeRenew/form?id=${employeeRenew.id}">员工续约列表</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="employeeRenew" action="${ctx}/crm/employeeRenew/save" onclick="submitData()" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="hdDataJSON">
		<input type="hidden" id="typeId" value="${employeeRenew.employeeEntry.type}">
		<input type="hidden" id="basePayStatusId" value="${employeeRenew.employeeEntry.basePayStatus}">
		<sys:message content="${message}"/>
		<c:if test="${renewApprovedList != null}">
			<div class="alert alert-info" style="margin-bottom:15px;"><strong><h3><font color="red">审批意见</font></h3></strong></div>
			<div class="control-group">
				<table class="table table-striped table-bordered table-condensed" style="width: 90%; text-align:left; margin:auto" border="1" cellpadding="2" cellspacing="1">
					<tr>
						<td>审判状态</td>
						<td>审批意见</td>
						<td>审批人</td>
						<td>审批时间</td>
					</tr>
					<tbody>
						<c:forEach items="${renewApprovedList}" var="renewApproved">
							<tr>
								<td>${erp:approvedRenewName(renewApproved.approvedStatus)}</td>
								<td>${renewApproved.approvedOpinion}</td>
								<td>${renewApproved.approvedUser.name}</td>
								<td><fmt:formatDate value="${renewApproved.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
							</tr>
						</c:forEach>
					</tbody>


				</table>
			</div>
		</c:if>

		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工基本信息</h4></strong></div>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed" style="width: 90%; text-align:left; margin:auto" border="1" cellpadding="2" cellspacing="1">
				<tr>
					<td>姓名</td>
					<td>性别</td>
					<td>手机号码</td>
					<td>工种</td>
					<td>来源</td>
					<td>出生日期</td>
				</tr>
				<tr>
					<td>${employeeRenew.employeeEntry.employee.name}</td>
					<td>${erp:sexStatusName(employeeRenew.employeeEntry.employee.sex)}</td>
					<td>${employeeRenew.employeeEntry.employee.phone}</td>
					<td><c:forEach items="${employeeRenew.employeeEntry.employee.getProfessionList()}" var="occId" varStatus="length">
						<c:if test="${length.index!=0}">
							,
						</c:if>
						${erp:getCommonsTypeName(occId)}
					</c:forEach></td>
					<td>${employeeRenew.employeeEntry.employee.customerResource.customerName}</td>
					<td><fmt:formatDate value="${employeeRenew.employeeEntry.employee.birthTime}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
			</table>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>员工定级和技能项信息</h4></strong></div>
		<h5>基础服务技能定级</h5>
		<div class="control-group">
			<table class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>基础服务技能</th>
					<c:forEach items="${weightList}" var="weight" varStatus="index">
						<input type="hidden" name="hdWeightId" value="${weight.id}">
						<th>${weight.checkName}得分</th>
					</c:forEach>
					<th>综合得分</th>
					<th>系统测评定级</th>
					<th>人工定级</th>
					<th>员工服务结算单价</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${employeeSkillList}" var="employeeSkill">
					<c:if test="${employeeSkill.type == 2}">
						<tr>
							<td>
									${employeeSkill.skill.skillName}
								<input type="hidden" name="skillEd" value="${employeeSkill.skill.id}">
							</td>
							<c:forEach items="${employeeSkill.skillWeightList}" var="skillWeight">
								<td weightId="${skillWeight.weightId}">
										${skillWeight.weightScore}
								</td>
							</c:forEach>
							<td name="score">
									${employeeSkill.score}
							</td>
							<td name="levelName">
									${employeeSkill.systemServiceLevel.name}
							</td>
							<td name="appraisalLevelName">
									${employeeSkill.serviceLevel.name}
							</td>
							<td>
									${employeeSkill.servicePrice}元/${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="control-group">
			<h5 style="float:left">员工服务技能 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5><a name="toSingleSkill" href="javascript:;" style="float:left">选择服务技能</a>
		</div>
		<div class="control-group">
			<table  id="skillContentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<th>技能项名称</th>
					<th>计价单位</th>
					<th>类型</th>
					<th>服务结算单价</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody tbodyName="singleSkill">
				<c:forEach items="${employeeSkillList}" var="employeeSkill">
					<c:if test="${employeeSkill.type == 1}">
						<tr id="">
							<td>
									${employeeSkill.skill.skillName}
								<input type="hidden" name="skillEd" value="${employeeSkill.skill.id}">
							</td>
							<td>
									${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
							<td>
								单项服务
							</td>
							<td>
									<input type="text" name="costomServicePrice" class="required number" value="${employeeSkill.servicePrice}">元/${erp:unitStatusName(employeeSkill.skill.unit)}
							</td>
							<td>
								<a href="javascript:;" id="${employeeSkill.skill.id}" name="singleSkillTest">
									删除
								</a>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>薪资结构</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;员工性质：</label>
			<div class="controls">
				<input type="radio" disabled="disabled" id="typeOne">劳务制
				<input type="radio" disabled="disabled" id="typeTwo">员工制
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;有无底薪：</label>
			<div class="controls">
				<input type="radio" disabled="disabled" id="basePayStatusOne">有底薪
				<input type="radio" disabled="disabled" id="basePayStatusTwo">无底薪
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span class="help-inline"><font color="red">*</font> </span> &nbsp;底薪：</label>
			<div class="controls">
				<form:input path="employeeEntry.baseAmount" htmlEscape="false" readonly="true" maxlength="64" class="input-xlarge "  style="width: 100px;"/> &nbsp;元/月
			</div>
		</div>
		<div class="alert alert-info" style="margin-bottom:15px;"><strong><h4>持续周期</h4></strong></div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;原合同编号：</label>
			<div class="controls">
				<form:input path="employeeEntry.contractCode"  htmlEscape="false" readonly="true" class="input-xlarge"  maxlength="64" style="width: 163px"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约生效日期：</label>
			<div class="controls">
				<input name="employeeEntry.takeTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${employeeRenew.employeeEntry.takeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;签约截止日期：</label>
			<div class="controls">
				<input name="employeeEntry.deadlineTime" type="text" disabled="disabled" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${employeeRenew.employeeEntry.deadlineTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约合同编号：</label>
			<div class="controls">
				<form:input path="contractExtensionCode" htmlEscape="false" class="required codeFormat input-xlarge" id="codeId" maxlength="20" style="width: 163px"/>
				<span id="spanId"><font color="red">请输入字母、数字</font></span>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约生效日期：</label>
			<div class="controls">
				<input name="extensionStartDate" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.extensionStartDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约截止日期：</label>
			<div class="controls">
				<input name="extensionEndDate" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.extensionEndDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group" style="float:left;">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;续约操作人：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${employeeRenew.user.id}"
								labelName="user.name" labelValue="${employeeRenew.user.name}"
								title="选择用户" url="/sys/office/treeData?type=3" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font color="red">*</font> </span> &nbsp;操作时间：</label>
			<div class="controls">
				<input name="createTime" type="text" readonly="readonly" maxlength="20" class="required input-medium Wdate "
					value="<fmt:formatDate value="${employeeRenew.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交续约申请"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
        $(document).ready(function() {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    submitData();
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

            $('a[name="toSingleSkill"]').click(function (){
                var skillIds = ''
                var trHtmls = $('[tbodyName="singleSkill"]').find('tr');
                for (var i=0;i<trHtmls.length;i++){
                    if(i<trHtmls.length-1){
                        skillIds = skillIds + $(trHtmls[i]).find('[type="hidden"]').val()+",";
                    }else{
                        skillIds = skillIds + $(trHtmls[i]).find('[type="hidden"]').val();
                    }
                }
                top.$.jBox("iframe:/crm/skill/toSingleSkill?skillIds="+skillIds,{
                    title:"员工技能定级",
                    width:1000,
                    height:400,
                    buttons:{},
                });
            })

			//点击删除按钮   移除单行元素
            $('a[name="singleSkillTest"]').on("click",function () {
                $(this).parent().parent().remove();
            })

			$("[name='costomServicePrice']").bind('input propertychange', function() {
				var amount = $('[name="costomServicePrice"]').val();
			});

            radioCheck();
            $('#spanId').hide();
		});

        //选择单项服务技能回调
        function singleSkillSelectCallback(id,name,unitName,categoryName,servicePrice,selectFlag,category) {
            if(selectFlag == '选择'){
                var trHTML = '<tr><td>'+name+'<input type="hidden" name="skillEd" value='+id+'></td><td>'+unitName+'</td>' +
                    '<td>'+categoryName+'</td><td><input type="text" name="costomServicePrice" value='+servicePrice+'>'+'元/'+unitName+'</td><td><a href="javascript:;"' +
                    ' id='+id+' name="singleSkillTest">删除</a></td></tr>'
                $('[tbodyName='+category+']').append(trHTML);
                $('a[name="singleSkillTest"][id='+id+']').on("click",function () {
                    $(this).parent().parent().remove();
                })
                $("[name='costomServicePrice']").on('input propertychange', function() {
                    var amount1 = $('[name="costomServicePrice"]').val();
                });
            }else if(selectFlag == '取消选择'){
                $('a[id='+id+']').parent().parent().remove();
            }
        }

        //拼接json数据
		function submitData() {
            var dataJSON = new Array();

            //拼接单项服务的json
			var trHTML = $('tbody[tbodyName="singleSkill"]').find('tr');
			for (var i = 0; i<trHTML.length; i++){
			    var trJSON = new Object();
                var skillId = $(trHTML[i]).find('input[type="hidden"][name="skillEd"]').val();
                var costomServicePrice = $(trHTML[i]).find('input[name="costomServicePrice"]').val();
                trJSON.type = 1;
                trJSON.skillId = skillId;
                trJSON.costomServicePrice = costomServicePrice;
                dataJSON.push(trJSON);
			}

			var hdDataJSONStr = JSON.stringify(dataJSON);
			$('input[type="hidden"][name="hdDataJSON"]').val(hdDataJSONStr);
		}

		//员工性质、有无底薪页面加载检查
		function radioCheck(){
            var type = $("#typeId").val();
            if (type == 1){
                $("#typeOne").attr("checked","true");
            }else{
                $("#typeTwo").attr("checked","true");
            }
            var basePayStatus = $("#basePayStatusId").val();
            if (basePayStatus == 1){
                $("#basePayStatusOne").attr("checked","true");
            }else{
                $("#basePayStatusTwo").attr("checked","true");
            }
		}

		//验证需求会改动，目前只验证数字、字母
        jQuery.validator.addMethod("codeFormat", function (value, element) {
            var reg = /^[0-9a-zA-Z]+$/;
            var value = $("#codeId").val();
            var flag = false;
            if (!reg.test(value)){
                flag = false;
			}else{
                flag = true;
			}
			return flag;
		}, "只能输入字母、数字");
	</script>
</body>
</html>