<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>上户信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
        $(document).ready(function() {
            //alert(${dispatch.statusFlag});
            $(document).find("a[name='customerView']").each(function () {
                var customerId = $(this).attr("customerId");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/customer/info?id="+customerId+"&&tagFlag="+1,{
                        title:"客户信息 ",
                        width:1100,
                        height:768,
                        buttons:{}
                    });
                });
            });
        });
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
		<%--<li <c:if test="${dispatch.status==0 && (dispatch.dispatchStatus==0 || empty dispatch.dispatchStatus)}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list">预约列表${dispatch.status}</a>
		</li>--%>
		<li <c:if test="${empty dispatch.dispatchEmployee.startServiceStatus && empty dispatch.statusFlag}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list">预约列表</a>
		</li>
		<%--<li <c:if test="${dispatch.dispatchEmployee.startServiceStatus==0 && dispatch.dispatchEmployee.recommendStatus==3}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list?dispatchEmployee.startServiceStatus=0&&dispatchEmployee.recommendStatus=3">待上户列表</a>
		</li>
		<li <c:if test="${dispatch.dispatchStatus==1 && dispatch.status==1 && dispatch.dispatchEmployee.startServiceStatus==1 && dispatch.dispatchEmployee.recommendStatus==3}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list?status=1&&dispatchStatus=1&&dispatchEmployee.startServiceStatus=1&&dispatchEmployee.recommendStatus=3">服务中列表</a>
		</li>
		<li <c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==3}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list?statusFlag=3">待下户列表</a>
		</li>
		<li <c:if test="${dispatch.dispatchStatus==1 && dispatch.dispatchEmployee.startServiceStatus==1 && dispatch.dispatchEmployee.recommendStatus==3 && dispatch.dispatchEmployee.endServiceStatus==1}">class="active"</c:if>>
			<a href="${ctx}/crm/dispatch/list?dispatchStatus=1&&dispatchEmployee.startServiceStatus=1&&dispatchEmployee.recommendStatus=3&&dispatchEmployee.endServiceStatus=1">已下户列表</a>
		</li>--%>

			<li <c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==1}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list?statusFlag=1">待上户列表</a>
			</li>
			<li <c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==2}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list?statusFlag=2">服务中列表</a>
			</li>
			<li <c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==3}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list?statusFlag=3">待下户列表</a>
			</li>
			<li <c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==4}">class="active"</c:if>>
				<a href="${ctx}/crm/dispatch/list?statusFlag=4">已下户列表</a>
			</li>
		<li><a href="${ctx}/crm/dispatch/form">预约上户</a></li>
	</ul>

	<form:form id="searchForm" modelAttribute="dispatch" action="${ctx}/crm/dispatch/list?statusFlag=${statusFlag}" method="post" class="breadcrumb form-search">
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
				<%--<th>预计金额</th>
				<th>实际金额</th>
				<th>结算方式</th>--%>
				<th>客户名称</th>
				<th>订单编号</th>
				<th>销售顾问</th>
				<th>预约项目</th>
				<th>服务类型</th>
				<th>购买数量</th>
				<th>服务次数</th>
				<c:if test="${empty dispatch.statusFlag}">
					<th>已推荐人数</th>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag}">
					<th>结算方式</th>
					<th>服务人员</th>
				</c:if>
				<th>预约上户时间</th>
				<c:if test="${empty dispatch.statusFlag }">
					<th>预约时间</th>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag!=1}">
					<th>实际上户时间</th>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==4}">
					<th>实际下户时间</th>
					<th>实际服务时长</th>
					<th>结算工资时长</th>
				</c:if>
				<c:if test="${empty dispatch.statusFlag }">
					<th>派工状态</th>
					<th>服务状态</th>
				</c:if>
				<%--<c:if test="${empty dispatch.statusFlag }">
					<th>订单状态</th>
				</c:if>--%>
				<%--<th>status</th>--%>
				<%--<th>新单（0是）</th>--%>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="newdispatch">
			<tr>
				<%--<td>${newdispatch.amount}</td>
				<td>${newdispatch.realAmount}</td>
				<td>${erp:dispatchPayTypeName(newdispatch.payType)}</td>--%>
				<td>
					<a name="customerView" customerId="${newdispatch.customer.id}" href="javascript:;" >${newdispatch.customer.name}</a>
				</td>

				<td>
					<a name="viewOrder" orderId="${newdispatch.order.id}" href="javascript:;">${newdispatch.order.orderCode}</a>
				</td>
				<td>
					${newdispatch.order.sale.name}
				</td>
				<td>
					${newdispatch.skill.skillName}
				</td>
				<td>
					${erp:skillCatageryName(newdispatch.skill.category)}
				</td>
				<td>
					${newdispatch.orderItem.product.measureWay==2 ? newdispatch.orderItem.num*newdispatch.orderItem.productSku.minStock:newdispatch.orderItem.num}
					${newdispatch.skill.category == 1 ? '次':'天'}
				</td>
				<td>
					<%--基础服务--%>
					<c:if test="${newdispatch.skill.category == 2}">
						${newdispatch.skillNum != newdispatch.usedNum ? 0:1}/1
					</c:if>
					<%--单项服务--%>
					<c:if test="${newdispatch.skill.category == 1}">
						${empty newdispatch.usedNum ? 0:newdispatch.usedNum}/
						${newdispatch.orderItem.product.measureWay==2 ? newdispatch.orderItem.num*newdispatch.orderItem.productSku.minStock:newdispatch.orderItem.num}
					</c:if>
				</td>
				<c:if test="${empty dispatch.statusFlag}">
					<td>
						${not empty newdispatch.recommendNum ? newdispatch.recommendNum:"0"}
					</td>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag }">
					<td>
						${erp:dispatchPayTypeName(newdispatch.payType)}
					</td>
					<td>
						${newdispatch.dispatchEmployee.employee.name}
					</td>
				</c:if>
				<td>
					<fmt:formatDate value="${newdispatch.planStartTime}" pattern="yyyy-MM-dd HH:mm"/>~~
					<fmt:formatDate value="${newdispatch.planEndTime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<c:if test="${empty dispatch.statusFlag }">
					<td>
						<fmt:formatDate value="${newdispatch.createTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag!=1}">
					<td>
						<fmt:formatDate value="${newdispatch.realStartTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</c:if>
				<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==4}">
					<td>
						<fmt:formatDate value="${newdispatch.realEndTime}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td>
						${newdispatch.serviceTime}小时
					</td>
					<td>
						<%--${empty newdispatch.realServiceTime? "":newdispatch.realServiceTime/24}${empty newdispatch.realServiceTime? "":"天"}--%>
						${empty newdispatch.realServiceTime? newdispatch.serviceTime:newdispatch.realServiceTime}小时
					</td>
				</c:if>
				<c:if test="${empty dispatch.statusFlag }">
					<td>
						${erp:dispatchStatusName(newdispatch.dispatchStatus)}
					</td>
					<td>
						${erp:dispatchBillStatusName(newdispatch.status)}
					</td>
				</c:if>
				<%--<c:if test="${empty dispatch.statusFlag }">
					<td>
							${newdispatch.order.status==4?'已完成':'未完成'}
					</td>
				</c:if>--%>
				<%--<td>
						${newdispatch.isNewDispatch}
				</td>--%>
				<%--<td>
					dispatchStatus=${dispatch.dispatchStatus}=status=${dispatch.status}=startServiceStatus=${dispatch.dispatchEmployee.startServiceStatus}
				</td>--%>
				<td>
					<%--预约列表--%>
					<c:if test="${empty newdispatch.dispatchEmployee.startServiceStatus && empty dispatch.statusFlag}">
						<c:if test="${newdispatch.dispatchStatus == 0}">
							<a name="serviceForm" dispatchId="${newdispatch.id}" href="javascript:;">推荐服务人员</a>&nbsp;&nbsp;
							<a name="taskForm" dispatchId="${newdispatch.id}" isRepetition="0" href="javascript:;">派工</a>
						</c:if>

					</c:if>
					<c:if test="${newdispatch.dispatchStatus==1 && newdispatch.status==2 && newdispatch.canRepetition==0 && newdispatch.usedNum < newdispatch.skillNum
								&&newdispatch.order.status!=4&&newdispatch.skill.category==2 && empty dispatch.statusFlag}">
						<a name="taskForm" dispatchId="${newdispatch.id}" isRepetition="1" href="javascript:;">重新派工</a>
						<a href="${ctx}/crm/dispatch/completeService?id=${newdispatch.id}"
						      onclick="return confirmx('确认该服务完成吗？', this.href)">服务完成
						</a>
					</c:if>
					<c:if test="${empty dispatch.statusFlag && newdispatch.status==0 && newdispatch.dispatchStatus == 1}">
						<a name="taskForm" dispatchId="${newdispatch.id}" isRepetition="2" href="javascript:;">重新派工</a>
					</c:if>
					<%--1.继承于上一单的不可取消2.未上户的可取消--%>
					<c:if test="${empty dispatch.statusFlag && newdispatch.status==0 && empty newdispatch.extendDispatch}">
						<a href="${ctx}/crm/dispatch/edit?id=${newdispatch.id}">修改</a>
						<a href="${ctx}/crm/dispatch/cancelDispatch?id=${newdispatch.id}"
						   onclick="return confirmx('确认要取消该预约服务吗？', this.href)">取消</a>
					</c:if>
					<c:if test="${empty dispatch.statusFlag}">
						<shiro:hasPermission name="crm:dispatch:info">
							<a href="${ctx}/crm/dispatch/info?id=${newdispatch.id}">详情</a>
						</shiro:hasPermission>
					</c:if>
					<%--<c:if test="${newdispatch.dispatchEmployee.startServiceStatus!=2 && newdispatch.dispatchEmployee.recommendStatus==3}">
						<a href="${ctx}/crm/dispatch/edit?id=${newdispatch.id}">修改</a>
						<a href="${ctx}/crm/dispatch/cancelDispatch?id=${newdispatch.id}"
							   onclick="return confirmx('确认要取消该预约服务吗？', this.href)">取消</a>
					</c:if>--%>
					<%--待上户列表--%>
					<c:if test="${not empty dispatch.statusFlag && newdispatch.dispatchEmployee.startServiceStatus!=2 && newdispatch.dispatchEmployee.recommendStatus==3}">
						<a name="confirmStartForm" service="0" dispatchId="${newdispatch.id}" dispatchEmpId="${newdispatch.dispatchEmployee.id}" href="javascript:;">确认上户</a>
					</c:if>
					<%--服务中列表--%>
					<c:if test="${not empty dispatch.statusFlag && newdispatch.dispatchStatus==1 && newdispatch.status==1 && newdispatch.dispatchEmployee.startServiceStatus==2 && newdispatch.dispatchEmployee.endServiceStatus!=2}">
					<%--<c:if test="${dispatch.statusFlag!=null && dispatch.statusFlag==2}">--%><%--<a name="taskForm" dispatchId="${dispatch.id}" href="javascript:;">督导上户记录审核</a>--%>
						<a name="confirmStartForm" service="1" dispatchId="${newdispatch.id}" dispatchEmpId="${newdispatch.dispatchEmployee.id}" href="javascript:;">提前下户</a>
					</c:if>
					<%--待下户列表--%>
					<c:if test="${not empty dispatch.statusFlag && dispatch.statusFlag==3}">
						<a name="confirmStartForm" service="2" dispatchId="${newdispatch.id}" dispatchEmpId="${newdispatch.dispatchEmployee.id}" href="javascript:;">确认下户</a>
					</c:if>
					<%--已下户列表--%>
					<c:if test="${not empty dispatch.statusFlag && newdispatch.skill.category == 2 && newdispatch.status==2 && newdispatch.dispatchStatus==1 && newdispatch.dispatchEmployee.startServiceStatus==2 && newdispatch.dispatchEmployee.recommendStatus==3 && newdispatch.dispatchEmployee.endServiceStatus==2}">
						<c:if test="${empty newdispatch.realServiceTime}">
							<a name="confirmStartForm" service="3" dispatchId="${newdispatch.id}" dispatchEmpId="${newdispatch.dispatchEmployee.id}" href="javascript:;">修改结算时长</a>
						</c:if>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<script type="text/javascript">

        function reloadAfterCloseMethod() {
            window.location.reload(true);
        }

        $(document).ready(function() {

            $(document).find("a[name='viewOrder']").each(function () {
                var orderId = $(this).attr("orderId");
                $(this).click(function () {
                    top.$.jBox("iframe:/erp/productOrder/view?id="+orderId,{
                        title:"查看订单",
                        width:1024,
                        height:550,
                        buttons:{}
                    });
                });
            });

            //推荐服务人员
            $(document).find("a[name='serviceForm']").each(function () {
                var dispatchId = $(this).attr("dispatchId");
                //alert(dispatchId);
                $(this).click(function () {
                    top.$.jBox.open("iframe:/crm/dispatchemployee/service",
                        "推荐服务人员",
                        1024,
                        550,
                        {
                            closed:function () {reloadAfterCloseMethod()},
                            ajaxData:{"dispatchId":dispatchId}
						}
                    );
                });
            });

            /*$(document).find("a[name='serviceForm']").each(function () {
                var dispatchId = $(this).attr("dispatchId");
                //alert(dispatchId);
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/dispatchemployee/service?dispatchId="+dispatchId,{
                        title:"推荐服务人员",
                        width:1024,
                        height:550,
                        buttons:{}
                    });
                });
            });*/


			//派工
            $(document).find("a[name='taskForm']").each(function () {
                var dispatchId = $(this).attr("dispatchId");
                var isRepetition = $(this).attr("isRepetition");
                $(this).click(function () {
                    if(isRepetition==0) {
                        top.$.jBox.open("iframe:/crm/dispatchemployee/task",
                            "派工",
                            1024,
                            550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"dispatchId":dispatchId,"isRepetition":isRepetition}
                            }
                        );
                    }else{
                        top.$.jBox.open("iframe:/crm/dispatchemployee/task",
                        	"重新派工",
                            1024,
                            550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"dispatchId":dispatchId,"isRepetition":isRepetition}
                            }
                    	);
					}
                });
            });

            // 0:确认上户 1:提前下户
            $(document).find("a[name='confirmStartForm']").each(function () {
                var dispatchEmpId = $(this).attr("dispatchEmpId");
                var dispatchId = $(this).attr("dispatchId");
                var service = $(this).attr("service");
                $(this).click(function () {
                    if(service==0) {
                        top.$.jBox.open("iframe:/crm/dispatch/confirmForm",
                        	"确认上户",
                             450,
                             550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"id":dispatchId,"dispatchEmpId":dispatchEmpId,"service":service}
                            }
                    	);
                        /*top.$.jBox("iframe:/crm/dispatch/confirmForm?id=" + dispatchId + "&&dispatchEmpId=" + dispatchEmpId + "&&service=" + service, {
                            title: "确认上户",
                            width: 450,
                            height: 550,
                            buttons: {}
                        });*/
                    }else if(service==1) {
                        top.$.jBox.open("iframe:/crm/dispatch/confirmForm",
                            "提前下户",
                            450,
                            550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"id":dispatchId,"dispatchEmpId":dispatchEmpId,"service":service}
                            }
                        );
					}else if(service==2) {
                        top.$.jBox.open("iframe:/crm/dispatch/confirmForm",
                            "确认下户",
                            450,
                            550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"id":dispatchId,"dispatchEmpId":dispatchEmpId,"service":service,"statusFlag":3}
                            }
                        );
					}else {
                        top.$.jBox.open("iframe:/crm/dispatch/confirmForm",
                            "确认下户",
                            450,
                            550,
                            {
                                closed:function () {reloadAfterCloseMethod()},
                                ajaxData:{"id":dispatchId,"dispatchEmpId":dispatchEmpId,"service":service,"statusFlag":4}
                            }
                        );
                    }
                });
            });
        });
	</script>
</body>
</html>