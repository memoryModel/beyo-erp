<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>服务订单</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        function selectEmployee(employeeId,name,code,phone,profession){
            console.log("#btnSelect"+employeeId,name,code,phone,profession);
            top.$.jBox.confirm('确认要选择添加该员工吗？','系统提示',function(v,h,f) {
                if (v == 'ok') {
                    parent.window.frames["mainFrame"].selectOrderCallback(employeeId,name,code,phone,profession);
                    top.$.jBox.close(true);
                }
            },{buttonsFocus:1, closed:function(){
                if (typeof closed == 'function') {
                    closed();
                }
            }});
            //close
        }
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">

		<li <c:if test="${empty dispatch.dispatchEmployee.startServiceStatus && empty dispatch.statusFlag}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list">预约列表</a>
		</li>

		<li <c:if test="${dispatch.dispatchStatus==1 && dispatch.status==1 && dispatch.dispatchEmployee.startServiceStatus==1 && dispatch.dispatchEmployee.recommendStatus==3}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list?status=1&&dispatchStatus=1&&dispatchEmployee.startServiceStatus=1&&dispatchEmployee.recommendStatus=3">服务中列表</a>
		</li>
	</ul>

	<form:form id="searchForm" modelAttribute="dispatch" action="${ctx}/crm/dispatch/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>客户姓名：</label>
				<form:input path="customer.name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li>
				<label>客户手机：</label>
				<form:input path="customer.phone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="clearfix"></li>
			<li>
				<label>预约项目</label>
				<form:select path="skill.id"  class="input-medium" id="productSkill">
					<form:option value="" label="------请选择------"/>
					<form:options items="${crmSkillList}" itemLabel="skillName" itemValue="id" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>是否推荐：</label>
				<form:select path="IsOrNoDispatch" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:option value="0" label="是"/>
					<form:option value="1" label="否"/>
				</form:select>
			</li>
			<li>
				<label>派工状态：</label>
				<form:select path="dispatchStatus" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:dispatchStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>服务状态：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label="------请选择------"/>
					<form:options items="${erp:dispatchBillStatusList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>上户时间：</label>
				<input name="planStartTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
				<input name="planEndTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   value="<fmt:formatDate value="${dispatch.planEndTime}" pattern="yyyy-MM-dd"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>
			<li><label>预约时间：</label>
				<input name="createTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>-
				<input name="createTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:true});"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>客户名称</th>
				<th>订单编号</th>
				<th>销售顾问</th>
				<th>预约项目</th>
				<th>服务类型</th>
				<th>服务次数</th>
				<th>已推荐人数</th>
				<th>预约上户时间</th>
				<th>预约时间</th>
				<th>派工状态</th>
				<th>服务状态</th>
				<th>status</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="dispatch">
			<tr>
				<td>
					<a name="customerView" customerId="${dispatch.customer.id}" href="javascript:;" >${dispatch.customer.name}</a>
				</td>

				<td>
					${dispatch.order.orderCode}
				</td>
				<td>
					${dispatch.order.sale.name}
				</td>
				<td>
					${dispatch.orderItem.productSku.skill.skillName}
				</td>
				<td>
					${erp:skillCatageryName(dispatch.orderItem.productSku.skill.category)}
				</td>
				<td>
					${dispatch.usedNum}/${dispatch.orderItem.num}
				</td>
				<td>
					${not empty dispatch.recommendNum ? dispatch.recommendNum:"0"}
				</td>

				<td>
					<fmt:formatDate value="${dispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>~~
					<fmt:formatDate value="${dispatch.planEndTime}" pattern="MM-dd HH:mm"/>
				</td>
				<td>
					<fmt:formatDate value="${dispatch.createTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${erp:dispatchStatusName(dispatch.dispatchStatus)}
				</td>
				<td>
					${erp:dispatchBillStatusName(dispatch.status)}
				</td>
				<td>dispatchStatus=${dispatch.dispatchStatus}=status=${dispatch.status}=startServiceStatus=${dispatch.dispatchEmployee.startServiceStatus}</td>
				<td>
					<%--预约列表--%>
					<c:if test="${empty dispatch.dispatchEmployee.startServiceStatus && empty dispatch.statusFlag}">
						<c:if test="${dispatch.dispatchStatus == 0}">
							<a name="serviceForm" dispatchId="${dispatch.id}" href="javascript:;">推荐服务人员</a>&nbsp;&nbsp;
							<a name="taskForm" dispatchId="${dispatch.id}" href="javascript:;">派工</a>
						</c:if>
						<c:if test="${dispatch.dispatchStatus == 1}">
							<a name="taskForm" dispatchId="${dispatch.id}" href="javascript:;">重新派工</a>
						</c:if>
					</c:if>
					<%--待上户列表--%>
					<c:if test="${dispatch.dispatchEmployee.startServiceStatus==0 && dispatch.dispatchEmployee.recommendStatus==3}">
						<a name="confirmStartForm" service="0" dispatchId="${dispatch.id}" dispatchEmpId="${dispatch.dispatchEmployee.id}" href="javascript:;">确认上户</a>
					</c:if>
					<%--服务中列表--%>
					<c:if test="${dispatch.dispatchStatus==1 && dispatch.status==1 && dispatch.dispatchEmployee.startServiceStatus==1 && empty dispatch.dispatchEmployee.endServiceStatus}">
						<%--<a name="taskForm" dispatchId="${dispatch.id}" href="javascript:;">督导上户记录审核</a>--%>
						<a name="confirmStartForm" service="1" dispatchId="${dispatch.id}" dispatchEmpId="${dispatch.dispatchEmployee.id}" href="javascript:;">提前下户</a>
					</c:if>
					<%--待下户列表--%>
					<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==3}">
						<a name="confirmStartForm" service="2" dispatchId="${dispatch.id}" dispatchEmpId="${dispatch.dispatchEmployee.id}" href="javascript:;">确认下户</a>
					</c:if>
					<%--已下户列表--%>
					<c:if test="${(dispatch.status==1 || dispatch.status==2) && dispatch.dispatchStatus==1 && dispatch.dispatchEmployee.startServiceStatus==1 && dispatch.dispatchEmployee.recommendStatus==3 && dispatch.dispatchEmployee.endServiceStatus==1}">
						<a name="confirmStartForm" service="3" dispatchId="${dispatch.id}" dispatchEmpId="${dispatch.dispatchEmployee.id}" href="javascript:;">修改结算时长</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<script type="text/javascript">
        $(document).ready(function() {

            //推荐服务人员
            $(document).find("a[name='serviceForm']").each(function () {
                var dispatchId = $(this).attr("dispatchId");
                //alert(dispatchId);
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/dispatchemployee/service?dispatchId="+dispatchId,{
                        title:"推荐服务人员",
                        width:1024,
                        height:650,
                        buttons:{}
                    });
                });
            });

			//派工
            $(document).find("a[name='taskForm']").each(function () {
                var dispatchId = $(this).attr("dispatchId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/dispatchemployee/task?dispatchId="+dispatchId,{
                        title:"派工",
                        width:1024,
                        height:650,
                        buttons:{}
                    });
                });
            });

            // 0:确认上户 1:提前下户
            $(document).find("a[name='confirmStartForm']").each(function () {
                var dispatchEmpId = $(this).attr("dispatchEmpId");
                var dispatchId = $(this).attr("dispatchId");
                var service = $(this).attr("service");
                $(this).click(function () {
                    if(service==0) {
                        top.$.jBox("iframe:/crm/dispatch/confirmForm?id=" + dispatchId + "&&dispatchEmpId=" + dispatchEmpId + "&&service=" + service, {
                            title: "确认上户",
                            width: 450,
                            height: 550,
                            buttons: {}
                        });
                    }else if(service==1) {
                        top.$.jBox("iframe:/crm/dispatch/confirmForm?id=" + dispatchId + "&&dispatchEmpId=" + dispatchEmpId + "&&service=" + service, {
                            title: "提前下户",
                            width: 450,
                            height: 550,
                            buttons: {}
                        });
					}else if(service==2) {
                        top.$.jBox("iframe:/crm/dispatch/confirmForm?id=" + dispatchId + "&&statusFlag=3"+ "&&dispatchEmpId=" + dispatchEmpId + "&&service=" + service, {
                            title: "确认下户",
                            width: 450,
                            height: 550,
                            buttons: {}
                        });
					}else {
                        top.$.jBox("iframe:/crm/dispatch/confirmForm?id=" + dispatchId + "&&statusFlag=3"+ "&&dispatchEmpId=" + dispatchEmpId + "&&service=" + service, {
                            title: "修改结算时长",
                            width: 450,
                            height: 550,
                            buttons: {}
                        });
                    }
                });
            });
        });
	</script>
</body>
</html>