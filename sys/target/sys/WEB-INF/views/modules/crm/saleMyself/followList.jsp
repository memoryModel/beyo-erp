
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>销售线索管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {

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

            $('a[name="giveUp"]').each(function(){
                var id = $(this).attr("id");
                $(this).click(function () {
                    top.$.jBox("iframe:/crm/sale/toGiveUp?id="+id,{
                        title:"放弃",
                        width:900,
                        height:500,
                        buttons:{},
                        closed:function () {
                            document.location.reload();
                        }
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
    <li class="active"><a href="${ctx}/crm/sale/saleMySelfList?followStatus=2">跟进中列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="sale" action="${ctx}/crm/sale/saleMySelfList" method="post" class="breadcrumb form-search">
    <input type="hidden" name="followStatus" value="2">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>线索来源：</label>
            <sys:treeselect id="customerResource" name="customerResource.id" value="${sale.customerResource.id}"
                            labelName="customerResource.customerName" labelValue="${sale.customerResource.customerName}"
                            title="来源名称" url="/erp/customerResource/treeData" cssClass="required" allowClear="true"/>
        </li>
        <li>
            <label>意向业务：</label>
            <form:select path="serviceTypeId" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:options items="${erp:getCommonsTypeList(59)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>意向门店：</label>

        </li>
        <li><label>重要程度：</label>
            <form:select path="importantDegree" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:options items="${erp:getCommonsTypeList(54)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>vip客户：</label>
            <form:select path="vipFlag" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:options items="${erp:findVipFlagList()}" itemLabel="name" itemValue="value" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>跟进阶段：</label>
            <form:select path="crmSaleFollow.followStage" style="width: 150px;">
                <form:option value="">请选择</form:option>
                <form:options items="${erp:getCommonsTypeList(9)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>客户意向：</label>
            <form:select path="crmSaleFollow.customerIntention" style="width: 150px;">
                <form:option value="">请选择</form:option>
                <form:options items="${erp:getCommonsTypeList(49)}" itemLabel="commonsName" itemValue="id" htmlEscape="false"/>
            </form:select>
        </li>
        <li>预计消费时间：
            <input name="startPlanConsumptionTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
                   value="<fmt:formatDate value="${sale.startPlanConsumptionTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
            <input name="endPlanConsumptionTime" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
                   value="<fmt:formatDate value="${sale.endPlanConsumptionTime}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
        </li>
        <li>最后跟进时间：
            <input name="crmSaleFollow.followTimeStart" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
                   value="<fmt:formatDate value="${sale.crmSaleFollow.followTimeStart}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>-
            <input name="crmSaleFollow.followTimeEnd" type="text" maxlength="20" class="input-medium Wdate " readonly="readonly"
                   value="<fmt:formatDate value="${sale.crmSaleFollow.followTimeEnd}" pattern="yyyy-MM-dd"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/></li>

        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
            <input id="batchToCancel" class="btn btn-primary" type="button" value="撤回"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>客户名称</th>
        <th>意向业务</th>
        <th>意向门店</th>
        <th>线索来源</th>
        <th>重要程度</th>
        <th>VIP客户</th>
        <th>预计消费时间</th>
        <th>销售顾问</th>
        <th>跟进阶段</th>
        <th>客户意向</th>
        <th>最后跟进时间</th>
        <th>委派时间</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="crmSale">
        <tr>
            <td>
                <a name="customerView" customerId="${crmSale.customer.id}" href="javascript:;" >${crmSale.customer.name}</a>
            </td>
            <td>
                    ${erp:getCommonsTypeName(crmSale.serviceTypeId)}
            </td>
            <td>
                意向门店
            </td>
            <td>
                    ${crmSale.customerResource.customerName}
            </td>
            <td>
                    ${erp:getCommonsTypeName(crmSale.importantDegree)}
            </td>
            <td>
                <c:if test="${crmSale.vipFlag == 0}">
                    是
                </c:if>
                <c:if test="${crmSale.vipFlag == 1}">
                    否
                </c:if>
            </td>
            <td>
                <fmt:formatDate value="${crmSale.planConsumptionTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                    ${crmSale.saleDelegateRecord.saleAdviserName.name}
            </td>
            <td>
                    ${erp:getFollowStatusName(crmSale.followStatus)}
            </td>
            <td>
                    ${erp:getCommonsTypeName(crmSale.crmSaleFollow.customerIntention)}
            </td>
            <td>
                <fmt:formatDate value="${crmSale.saleDelegateRecord.delegateTime}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                最后跟进时间
            </td>
            <td>
                <shiro:hasPermission name="crm:sale:saleInfo"><a href="${ctx}/crm/saleFollow/view?saleId=${crmSale.id}&&tagFlag=2">查看</a></shiro:hasPermission>
                <a href="${ctx}/crm/saleFollow/form?saleId=${crmSale.id}&&saleDelegateRecordId=${crmSale.saleDelegateRecord.id}&&followStatus=2">添加跟进记录</a>
                <a href="${ctx}/erp/productOrder/form?saleId=${crmSale.id}&customerId=${crmSale.customer.id}&customerName=${crmSale.customer.name}">添加预定订单</a>
                <a name="giveUp" href="javascript:;" id="${crmSale.id}">放弃</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>