<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户员工管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        var dispatchId = ${dispatch.id};
        var dispatchEmployeeList = ${fns:toJson(dispatchEmployeeList)};
        var employeeTableTemplate;
        var dispatchEmployeeArray = new Array();

		$(document).ready(function() {
            //alert(${dispatch.id});
            $("input[name='closeWindows']").each(function () {
                $(this).click(function () {
                    //parent.location.reload();
                    top.$.jBox.close(true);
                });
            });

            if(${empty result}) employeeTableTemplate = $("#employeeTableTemplate").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");

            for(var k=0;k<dispatchEmployeeArray.length;k++) {
                var obj = dispatchEmployeeArray[k];
                console.log(obj);
                $("#checkbox"+obj.employeeId).attr("checked",true);
			}

            appendTable();
		});

        function appendTable(){
            $("#employeeTable").empty();
            $("#employeeTable").append(Mustache.render(employeeTableTemplate, {"dispatchEmployeeArray":dispatchEmployeeArray}));
            $("#dispatchEmployeeJson").val(JSON.stringify(dispatchEmployeeArray));
        }

        //读取后台传递的已有数据
        for(var i=0;i<dispatchEmployeeList.length;i++){
            var obj = dispatchEmployeeList[i];
            console.info(obj);
            var dispatchId = obj.dispatch.id;
            var employeeId = obj.employee.id;
            var empName = obj.employee.name;
            var jobNumber = obj.employee.code;
			var profession = obj.employee.professionName ==null ? " ":obj.employee.professionName;
			var serviceYear = obj.employee.serviceYear ==null ? " ":obj.employee.serviceYear+'年';
			var serviceLevelName = obj.employee.serviceLevelName ==null ? " ":obj.employee.serviceLevelName;
			var servicePrice = obj.employee.skillServicePrice ==null ? " ":obj.employee.skillServicePrice;

            var key = employeeId+empName;
            console.log("employeeId:"+employeeId+"empName:"+empName+"jobNumber:"+jobNumber);

            pushEmployeeArray(key,employeeId,dispatchId,empName,jobNumber,profession,serviceYear,serviceLevelName,servicePrice);

        }

        //追加数据
        function pushEmployeeArray(key,employeeId,dispatchId,empName,jobNumber,profession,serviceYear,serviceLevelName,servicePrice){
            dispatchEmployeeArray.push({
                "key":key,
                "employeeId":employeeId,
                "dispatchId":dispatchId,
                "empName":empName,
                "jobNumber":jobNumber,
                "profession":profession,
                "serviceYear":serviceYear,
                "serviceLevelName":serviceLevelName,
                "servicePrice":servicePrice
            });
        }

        //选择员工
        function selectEmployee(employeeId,empName,jobNumber,profession,serviceYear,serviceLevelName,servicePrice){
            console.log("#chkEmp"+employeeId+"--"+empName+"--"+jobNumber+"--"+"profession"+profession+"--"+"serviceYear"+serviceYear+"--"+""+"--"+""+"--"+"");
            var chked = $("#checkbox"+employeeId).attr("checked");

            for (var i = 0; i < dispatchEmployeeArray.length; i++) {
                if (employeeId == dispatchEmployeeArray[i].employeeId) {
                    if (chked) {
                        return;
                    } else {
                        dispatchEmployeeArray.remove(i);
                        appendTable();
                        return;
                    }
                }
            }

            var key = employeeId+empName;
            pushEmployeeArray(key,employeeId,dispatchId,empName,jobNumber,profession,serviceYear,serviceLevelName,servicePrice);
            appendTable();
        }

        //移除元素
        Array.prototype.remove=function(dx){
            if(isNaN(dx)||dx>this.length){return false;}
            for(var i=0,n=0;i<this.length;i++)
            {
                if(this[i]!=this[dx])
                {
                    this[n++]=this[i]
                }
            }
            this.length-=1
        };

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }

		function sub() {
			$("#searchForm").attr("action","${ctx}/crm/dispatchemployee/service?dispatchId="+$("#dispatchId").val());
            //alert($("#searchForm").attr("action"));
        }

        /*function saveDispatchEmp() {
            $("#inputForm").attr("action","${ctx}/crm/dispatchemployee/save?tagFlag="+${tagFlag});
        }*/

	</script>
</head>
<body>
	<br/>
	<c:if test="${empty result}">
	<strong>手动选择服务人员:</strong><br/>
	<input type="hidden" id="dispatchEmployeeJson" />

	<form:form id="searchForm" modelAttribute="employee" onsubmit="sub()" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%--<li>
				<form:input path="name" placeholder="请输入员工名称/编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
			</li>--%>
			<li><label>员工：</label>
				<input name="name" placeholder="请输入员工名称/编号" htmlEscape="false" maxlength="20" style="width:200px;" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<%--<th>id</th>--%>
				<th>选择人员</th>
				<th>员工姓名</th>
				<th>员工编号</th>
				<th>技能点</th>
				<th>工作经验</th>
				<th>星级</th>
				<th>结算价格</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="employee">
			<tr>
				<%--<td>
					${employee.id}
				</td>--%>
				<td>
					<input type="checkbox" id="checkbox${employee.id}" onclick="selectEmployee(
							'${employee.id}','${employee.name}','${employee.code}','${erp:getCommonsTypeName(employee.profession)}',
							'${employee.serviceYear}年','${employee.serviceLevel.name}','${employee.employeeSkill.servicePrice}')"/>
				</td>
				<td>
					${employee.name}
				</td>
				<td>
					${employee.code}
				</td>
				<td>
					${erp:getCommonsTypeName(employee.profession)}
				</td>
				<td>
					${not empty employee.serviceYear? employee.serviceYear:' '}${not empty employee.serviceYear? '年':' '}
					<%--<fmt:formatDate value="${employee.entryTime}" pattern="yyyy-MM-dd HH:mm"/>--%>
				</td>
				<td>
					${employee.serviceLevel.name}
				</td>
				<td>
					${employee.employeeSkill.servicePrice}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<form:form id="inputForm" modelAttribute="dispatchEmployee" action="${ctx}/crm/dispatchemployee/save?tagFlag=${empty tagFlag? 0:tagFlag}" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<input type="hidden" id="dispatchId" name="dispatch.id" value="${dispatch.id}"/>


		<strong>已选择服务人员:</strong><br/>
		<table id="empTable" class="table table-striped table-bordered table-condensed">
			<thead>
			<tr>
				<%--<th>dispatchId</th>
				<th>employeeId</th>--%>
				<th>员工姓名</th>
				<th>员工编号</th>
				<th>技能点</th>
				<th>工作经验</th>
				<th>星级</th>
				<th>结算价格</th>
				<th>操作</th>
			</tr>
			</thead>
			<tbody id="employeeTable">
			<script type="text/template" id="employeeTableTemplate">
				{{#dispatchEmployeeArray}}
				<tr>
					<%--<td>{{dispatchId}}</td>
					<td>{{employeeId}}</td>--%>
					<td>{{empName}}</td>
					<td>{{jobNumber}}</td>
					<td>{{profession}}</td>
					<td>{{serviceYear}}</td>
					<td>{{serviceLevelName}}</td>
					<td>{{servicePrice}}</td>
					<td>
						<input type="hidden" name="employeeId" value="{{employeeId}}">
						<input id="removeEmp{{employeeId}}" class="btn btn-danger" type="button" value="删 除"
							   onclick="removeEmp('{{employeeId}}')"/>
					</td>
				</tr>
				{{/dispatchEmployeeArray}}
			</script>
			</tbody>

		</table>


		<div class="form-actions">
				<%--<shiro:hasPermission name="crm:dispatchEmployee:save">--%>
			<input id="btnFormSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<%--</shiro:hasPermission>--%>
			<input name="closeWindows" class="btn" type="button" value="关闭"/>
		</div>


	</form:form>
	</c:if>
	<c:if test="${!empty result}">
		<div class="form-actions">
			<c:choose>
				<c:when test="${result == 'success'}">
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>推荐成功</div>
				</c:when>
				<c:otherwise>
					<div id="messageBox" class="alert alert-success"><button data-dismiss="alert" class="close">×</button>推荐失败</div>
				</c:otherwise>
			</c:choose>
			<c:if test="${tagFlag!=1}">
				<input name="closeWindows" class="btn" type="button" value="关 闭"/>
			</c:if>
		</div>
	</c:if>

</body>
</html>