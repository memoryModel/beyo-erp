<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>员工定级</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        var weightIdArray = new Array();
	</script>
</head>
<body>

<form:form id="inputForm" modelAttribute="entry" action="${ctx}/crm/entry/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="employee.id" id="employeeId"/>
	<input type="hidden" name="hdWeightListSize" value="${weightListSize}">
	<input type="hidden" name="hdDataJSON" value="">
	<sys:message content="${message}"/>
	<div class="alert alert-info">员工定级</div>
	<div class="control-group">
		* 定级员工:${entry.employee.name}
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
				<fmt:formatDate value="${entry.employee.birthTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
		</tr>

	</table>

	<div class="alert alert-info">员工等级</div>
	<div class="control-group">
		基础服务技能定级 <a name="toBesicSkill" href="javascript:;">选择基础服务技能</a>
	</div>
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
				<th>操作</th>
			</tr>
			</thead>
			<tbody tbodyName="besicSkill">
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
						<td name="costomServicePrice">
								${employeeSkill.servicePrice}元/${erp:unitStatusName(employeeSkill.skill.unit)}
						</td>
						<td>
							<a href="javascript:;" id="${employeeSkill.skill.id}" name="skillTest">测评定级</a>
						</td>
						<input type="hidden" name="levelId" value="${employeeSkill.systemServiceLevel.id}">
						<input type="hidden" name="appraisalLevelId" value="${employeeSkill.serviceLevel.id}">
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	</div>

	<div id="contentTable" class="alert alert-info">技能项</div>
	<div class="control-group">
		员工服务技能 <a name="toSingleSkill" href="javascript:;">选择服务技能</a>
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
					<tr>
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
								<input type="text" class="required number" name="costomServicePrice" value="${employeeSkill.servicePrice}">
								元/${erp:unitStatusName(employeeSkill.skill.unit)}
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

	<div class="control-group">
		* 定级操作人：
		<input type="text"  value="${interview.interviewers.name}" readonly="readonly" >
		&nbsp;&nbsp;&nbsp;&nbsp;
		* 定级操作时间：
		<input type="text" class="checkSkill checkScore" value="<fmt:formatDate value="${skillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly">

		<input type="hidden" name="skillPersonId" value="${interview.interviewers.id}">
		<input type="hidden" name="skillTime" value="<fmt:formatDate value="${skillTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
	</div>


	<div class="form-actions">
		<shiro:hasPermission name="crm:entry:save"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
<script type="text/javascript">

    $('input[type="hidden"][name="hdWeightId"]').each(function () {
        weightIdArray.push($(this).val())
    })

    $(function () {
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

        //验证是否选择技能
        jQuery.validator.addMethod("checkSkill", function (value, element) {
            var flag = true;
            var trHTML = $('tbody[tbodyName="besicSkill"],tbody[tbodyName="singleSkill"]').find('tr');
            if(trHTML == null || trHTML == '' || ('undefined' == typeof trHTML) || trHTML.length<=0){
                flag = false;
			}
			if(flag == true){
                submitData();
			}
            return flag;
        }, "请选择技能");

        //验证是否基础技能是否进行了测评
        jQuery.validator.addMethod("checkScore", function (value, element) {
            var flag = true;
            var trHTML = $('tbody[tbodyName="besicSkill"]').find('tr');
            if(trHTML != null && trHTML != '' && ('undefined' != typeof trHTML) && trHTML.length>0){
                for(var i=0;i<trHTML.length;i++){
                    var score = $(trHTML[i]).find('td[name="score"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                    if(score == null || score == '' || ('undefined' == typeof  score)){
                        flag = false;
						break;
					}
				}
            }else{
                flag = false;
			}
			if(flag == true){
                submitData();
			}
            return flag;
        }, "请测评基础技能");

        $('a[name="toBesicSkill"]').click(function () {
            var skillIds = ''
            var trHtmls = $('[tbodyName="besicSkill"]').find('tr');
            for (var i=0;i<trHtmls.length;i++){
                if(i<trHtmls.length-1){
                    skillIds = skillIds + $(trHtmls[i]).find('[type="hidden"]').val()+",";
                }else{
                    skillIds = skillIds + $(trHtmls[i]).find('[type="hidden"]').val();
                }
            }
            top.$.jBox("iframe:/crm/skill/toBesicSkill?skillIds="+skillIds,{
                title:"基础服务技能定级",
                width:1000,
                height:600,
                buttons:{},
                /* closed:function () {
                    document.location.reload();
                }*/
            });
        });

        $('a[name="toSingleSkill"]').click(function () {
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
                /* closed:function () {
                     document.location.reload();
                 }*/
            });
        });

        $('a[name="skillTest"]').on("click",function () {
            var employeeSkill = new Object();
            var score = $(this).parent().parent().find('td[name="score"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
            employeeSkill.score = score;
            var costomServicePriceAndUnit = $(this).parent().parent().find('td[name="costomServicePrice"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
            employeeSkill.servicePrice = costomServicePriceAndUnit.substring(0,costomServicePriceAndUnit.indexOf('元'));

            var systemServiceLevel = new Object();
            systemServiceLevel.id = $(this).parent().parent().find('input[type="hidden"][name="levelId"]').val();
            systemServiceLevel.name = $(this).parent().parent().find('td[name="levelName"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");

            var serviceLevel = new Object();
            serviceLevel.id = $(this).parent().parent().find('input[type="hidden"][name="appraisalLevelId"]').val();
            serviceLevel.name = $(this).parent().parent().find('td[name="appraisalLevelName"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");

            var skillWeightList = new Array();
            var weightTDHTML = $(this).parent().parent().find('td[weightId]');
            for(var i=0;i<weightTDHTML.length;i++){
                var weight = new Object();
                weight.weightId = $(weightTDHTML[i]).attr('weightId');
                weight.weightScore = $(weightTDHTML[i]).text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                skillWeightList.push(weight);
            }

            employeeSkill.systemServiceLevel = systemServiceLevel;
            employeeSkill.serviceLevel = serviceLevel;
            employeeSkill.skillWeightList = skillWeightList;


            var employeeSkillStr = '';
            if(score != null && score !=''){
                employeeSkillStr = JSON.stringify(employeeSkill)
            }

            var employeeId = $("#employeeId").val();
            var skillId = $(this).attr('id');
            top.$.jBox("iframe:/crm/entry/employeeSkill?employeeId="+employeeId+"&skillId="+skillId+"&employeeSkillJSON="+employeeSkillStr,
                {title:"技能等级综合评测",
                    width:600,
                    height:650,
                    buttons:{}
                }
            );
        })

        $('a[name="singleSkillTest"]').on("click",function () {
            $(this).parent().parent().remove();
        })

    })

    //选择基础技能回调
    function skillSelectCallback(id,name,selectFlag,category){
        var employeeId = $("#employeeId").val();
        if(selectFlag == '选择'){
            var weightListSize = $('[name="hdWeightListSize"]').val();
            var tdHTML = '';
            for(var i=0;i<weightIdArray.length;i++){
                tdHTML = tdHTML + '<td weightId='+weightIdArray[i]+'></td>';
            }
            var trHTML = '<tr><td>'+name+'<input type="hidden" name="skillEd" value='+id+'></td>'+tdHTML+'<td name="score"></td>' +
                '<td name="levelName"></td><td name="appraisalLevelName"></td><td name="costomServicePrice"></td><td><a href' +
                '="javascript:;" id='+id+' name="skillTest">测评定级</a></td><input type="hidden" name="levelId">' +
                '<input type="hidden" name="appraisalLevelId"></tr>'

            $('[tbodyName='+category+']').append(trHTML);
            $('a[name="skillTest"][id='+id+']').on("click",function () {
                var employeeSkill = new Object();
                var score = $(this).parent().parent().find('td[name="score"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                    employeeSkill.score = score;
                    var costomServicePriceAndUnit = $(this).parent().parent().find('td[name="costomServicePrice"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                    employeeSkill.servicePrice = costomServicePriceAndUnit.substring(0,costomServicePriceAndUnit.indexOf('元'));

                    var systemServiceLevel = new Object();
                    systemServiceLevel.id = $(this).parent().parent().find('input[type="hidden"][name="levelId"]').val();
                    systemServiceLevel.name = $(this).parent().parent().find('td[name="levelName"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");

                    var serviceLevel = new Object();
                    serviceLevel.id = $(this).parent().parent().find('input[type="hidden"][name="appraisalLevelId"]').val();
                    serviceLevel.name = $(this).parent().parent().find('td[name="appraisalLevelName"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");

                    var skillWeightList = new Array();
                    var weightTDHTML = $(this).parent().parent().find('td[weightId]');
                    for(var i=0;i<weightTDHTML.length;i++){
                        var weight = new Object();
                        weight.weightId = $(weightTDHTML[i]).attr('weightId');
                        weight.weightScore = $(weightTDHTML[i]).text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                        skillWeightList.push(weight);
                    }

                    employeeSkill.systemServiceLevel = systemServiceLevel;
                    employeeSkill.serviceLevel = serviceLevel;
                    employeeSkill.skillWeightList = skillWeightList;


                var employeeSkillStr = '';
                if(score != null && score !=''){
                    employeeSkillStr = JSON.stringify(employeeSkill)
				}

                var skillId = $(this).attr('id');
                top.$.jBox("iframe:/crm/entry/employeeSkill?employeeId="+employeeId+"&skillId="+skillId+"&employeeSkillJSON="+employeeSkillStr,
                    {title:"技能等级综合评测",
                        width:600,
                        height:650,
                        buttons:{}
                    }
                );
            })
        }else if(selectFlag == '取消选择'){
            $('a[id='+id+']').parent().parent().remove();
        }
    }

    //选择单项服务技能回调
    function singleSkillSelectCallback(id,name,unitName,categoryName,servicePrice,selectFlag,category) {
        if(selectFlag == '选择'){
            var trHTML = '<tr><td>'+name+'<input type="hidden" name="skillEd" value='+id+'></td><td>'+unitName+'</td>' +
                '<td>'+categoryName+'</td><td><input type="text" class="required number" name="costomServicePrice" value='+servicePrice+'>'+'元/'+unitName+'</td><td><a href="javascript:;"' +
                ' id='+id+' name="singleSkillTest">删除</a></td></tr>'
            $('[tbodyName='+category+']').append(trHTML);
            $('a[name="singleSkillTest"][id='+id+']').on("click",function () {
                $(this).parent().parent().remove();
            })
        }else if(selectFlag == '取消选择'){
            $('a[id='+id+']').parent().parent().remove();
        }
    }

    //基础技能评测后回调
    function employeeSkillCallback(skillId,pointsValueArray,score,levelId,levelName,
                                   servicePrice,appraisalLevelId,appraisalLevelName,costomServicePrice,unit) {
        if(unit == "1"){
            unit = "元/天";
        }else{
            unit = "元/次";
        }

        for(var i=0;i<pointsValueArray.length;i++){
            $('a[id='+skillId+']').parent().parent().find('td:eq('+(i+1)+')').text(pointsValueArray[i]);
        }
        $('a[id='+skillId+']').parent().parent().find('td[name="score"]').text(score);
        $('a[id='+skillId+']').parent().parent().find('td[name="levelName"]').text(levelName);
        $('a[id='+skillId+']').parent().parent().find('td[name="appraisalLevelName"]').text(appraisalLevelName);
        $('a[id='+skillId+']').parent().parent().find('td[name="costomServicePrice"]').text(costomServicePrice+unit);
        $('a[id='+skillId+']').parent().parent().find('input[type="hidden"][name="levelId"]').val(levelId);
        $('a[id='+skillId+']').parent().parent().find('input[type="hidden"][name="appraisalLevelId"]').val(appraisalLevelId);
    }

    //拼接json数据
    function submitData() {
        var dataJSON = new Array();
        //拼接基础服务的json
        var trHTML = $('tbody[tbodyName="besicSkill"]').find('tr');
        for (var i=0;i<trHTML.length;i++){
            var trJSON = new Object();
            var weightArray = new Array();
            var tdHTML = $(trHTML[i]).find('td');
            for (var j=0;j<tdHTML.length;j++){
                var weightId = $(tdHTML[j]).attr('weightId');
                if(weightId != null && weightId != '' && ('undefined' != typeof weightId)){
                    for(var z=0;z<weightIdArray.length;z++){
                        if(weightIdArray[z] == weightId){
                            var weight = new Object();
                            weight.weightId = weightId;
                            weight.score = $(tdHTML[j]).text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
                            weightArray.push(weight);
                            break;
                        }
                    }
                }
            }
            var skillId = $(trHTML[i]).find('input[type="hidden"][name="skillEd"]').val();
            trJSON.type = 2;
            trJSON.skillId = skillId;
            trJSON.score = $(trHTML[i]).find('td[name="score"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
            trJSON.levelId = $(trHTML[i]).find('input[type="hidden"][name="levelId"]').val();
            trJSON.appraisalLevelId = $(trHTML[i]).find('input[type="hidden"][name="appraisalLevelId"]').val();
            var priceAndUnit = $(trHTML[i]).find('td[name="costomServicePrice"]').text().replace(/[\r\n\t]/g,"").replace(/\s+/g, "");
            trJSON.costomServicePrice = priceAndUnit.substring(0,priceAndUnit.indexOf('元'));
            trJSON.skillPersonId = $('input[type="hidden"][name="skillPersonId"]').val();
            trJSON.skillTime = $('input[type="hidden"][name="skillTime"]').val();
            trJSON.weightArray = weightArray;
            dataJSON.push(trJSON);
        }
        //拼接单项服务的json
        var trHTML2 = $('tbody[tbodyName="singleSkill"]').find('tr');
        for(var i=0;i<trHTML2.length;i++){
            var trJSON = new Object();
            var skillId = $(trHTML2[i]).find('input[type="hidden"][name="skillEd"]').val();
            var costomServicePrice = $(trHTML2[i]).find('input[name="costomServicePrice"]').val();
            trJSON.type = 1;
            trJSON.skillId = skillId;
            trJSON.costomServicePrice = costomServicePrice;
            trJSON.skillPersonId = $('input[type="hidden"][name="skillPersonId"]').val();
            trJSON.skillTime = $('input[type="hidden"][name="skillTime"]').val();
            dataJSON.push(trJSON);
        }
        var hdDataJSONStr = JSON.stringify(dataJSON);
        $('input[type="hidden"][name="hdDataJSON"]').val(hdDataJSONStr);
        //console.log(hdDataJSONStr)
    }

</script>
</body>
</html>