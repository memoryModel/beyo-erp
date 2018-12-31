<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>班级管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>
			<input type="checkbox" name="checkboxs">
		</th>
		<th>班级名称</th>
		<th>价格</th>
		<th>班主任</th>
		<th>报班学员</th>
		<th>入班率</th>
		<th>开班日期</th>
		<th>创建时间</th>
		<th>班级状态</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${classList}" var="schoolClass">
		<tr>
			<td>
				<input type="checkbox" name="checkbox" className="${schoolClass.className}" value="${schoolClass.id}">
			</td>
			<td>
					${schoolClass.className}
			</td>
			<td>
					${schoolClass.tuitionAmount}
			</td>
			<td>
					${schoolClass.headteacher.name}
			</td>
			<td>
					${empty schoolClass.classRealNum ? '':schoolClass.classRealNum}
					${empty schoolClass.classRealNum ? '':'/'}
					${empty schoolClass.classRealNum ? '':schoolClass.classMaxNum}
			</td>
			<td>
				<fmt:formatNumber type="number" value="${schoolClass.classRealNum*100/schoolClass.classMaxNum}" maxFractionDigits="0"/>%
			</td>
			<td>
				<fmt:formatDate value="${schoolClass.realBeginTime}" pattern="yyyy-MM-dd"/>
			</td>
			<td>
				<fmt:formatDate value="${schoolClass.createTime}" pattern="yyyy-MM-dd HH:mm"/>
			</td>
			<td>
					${erp:classStatusName(schoolClass.status)}
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<script type="text/javascript">
    $(document).ready(function() {
        jQueryCheckAll();
        $('[type="checkbox"]').click(function () {
            var classIds = '';
            var classNames = '';
            var chechboxHtml = $('[type="checkbox"][name="checkbox"]:checked');
            for(var i=0;i<chechboxHtml.length;i++){
                    if(i == chechboxHtml.length-1){
                        classIds = classIds + $(chechboxHtml[i]).val();
                        classNames = classNames + $(chechboxHtml[i]).attr('className');
					}else{
                        classIds = classIds + $(chechboxHtml[i]).val() + ',';
                        classNames = classNames + $(chechboxHtml[i]).attr('className') + ',';
					}
			}
            parent.window.frames["mainFrame"].selectClassallback(classIds,classNames);
        })
    });

    function checkedIds() {
        var ids = '';
        var elements = $("[name='checkbox']:checked");
        for (var  i = 0; i<elements.length;i++){
            if(i<elements.length-1){
                ids = ids + $(elements[i]).val()+",";
            }else{
                ids = ids + $(elements[i]).val();
            }
        }
        return ids;
    }

    function jQueryCheckAll(){
        var checkAll = $('[name="checkboxs"]');
        var items = $('[name="checkbox"]');
        checkAll.click(function () {
            if ($(this).attr('checked')) {
                items.each(function () {
                    $(this).attr('checked', true);
                })
            }else {
                items.each(function () {
                    $(this).attr('checked', false);
                })
            }
            items.click(function () {
                checkAll.attr("checked", items.length == $('[name="checkbox"]:checked').length ? true : false);
            });
        })
    }
</script>
</body>
</html>