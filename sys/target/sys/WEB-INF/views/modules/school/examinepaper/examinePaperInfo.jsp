<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试卷详情</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="/school/examinePaper/list">试卷管理</a></li>
		<li class="active"><a href="/school/examinePaper/view?id=${examinePaper.id}">试卷详情</a></li>
	</ul><br/>
	<div class="form-horizontal">
		<div class="control-group">
			<div class="controls">
				<h3>${examinePaper.examineInfo.examineName}&nbsp;&nbsp;(${erp:examTypeName(examinePaper.examineInfo.examineType)})</h3>
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				<%--课程：${examinePaper.classToLesson.schoolClassLesson.lessonName}&nbsp;&nbsp;&nbsp;&nbsp;--%>
				答题时长：${examinePaper.examineInfo.examineLength}&nbsp;分钟
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				学员：${examinePaper.student.name}&nbsp;&nbsp;(${examinePaper.student.studentNumber})

			</div>
		</div>

		<c:forEach items="${list}" var="question" varStatus="seq">
			<div class="control-group">
				<div class="controls">
					${seq.index+1}.<c:if test="${examinePaper.examineInfo.examineType==1}">&nbsp;[${erp:examQuestionTypeName(question.type)}]</c:if>&nbsp;${question.title}：&nbsp;&nbsp;&nbsp;&nbsp;
				<br><br>

				<ul>
					<c:forEach items="${question.answerList}" var="answer">
						<li>
								${answer.reference}.&nbsp;${answer.title}
						</li>
					</c:forEach>
				</ul>
				正确答案：
				<c:forEach items="${question.answerList}" var="answer">
					<c:if test="${answer.solution==1}">
						${answer.reference}&nbsp;
					</c:if>
				</c:forEach>
				</div>
			</div>

		</c:forEach>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</div>







</body>
</html>