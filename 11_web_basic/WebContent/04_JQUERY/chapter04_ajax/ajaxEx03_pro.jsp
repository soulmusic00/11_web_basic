<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxPro</title>
</head>
<body>

	<%
	
		String dbId = "admin";
		String id = request.getParameter("id");
		
		String result = "N";
		if (id.equals(dbId)) {
			result = "Y";
		}
		
	%>
	<p id="res"><%=result %></p>

</body>
</html>


