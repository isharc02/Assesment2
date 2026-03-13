<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String pid = request.getParameter("id");

if(pid == null){
    response.sendRedirect("profile.jsp");
    return;
}

int id = Integer.parseInt(pid);

Connection cn = new DBUtil().getConnectionData();

PreparedStatement ps = cn.prepareStatement("select * from blogs where id=?");
ps.setInt(1,id);

ResultSet rs = ps.executeQuery();

if(!rs.next()){
    response.sendRedirect("profile.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Edit Post</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<%@ include file="navbar.jsp" %>

<div class="container mt-5">

<h2>Edit Post</h2>

<form action="EditPostController" method="post">

<input type="hidden" name="id" value="<%=rs.getInt("id")%>">

<input type="hidden" name="action" value="edit">

<div class="mb-3">

<label>Title</label>

<input type="text" name="title" class="form-control"
value="<%=rs.getString("title")%>" required>

</div>


<div class="mb-3">

<label>Tags</label>

<textarea name="tags" class="form-control" rows="3"><%=rs.getString("tags")%></textarea>

</div>


<div class="mb-3">

<label>Content</label>

<textarea name="context" class="form-control" rows="12" required><%=rs.getString("context")%></textarea>

</div>


<button type="submit" class="btn btn-primary">
Update Post
</button>

<a href="profile.jsp" class="btn btn-secondary">
Cancel
</a>

</form>

</div>

<%@ include file="footer.jsp" %>

</body>
</html>

<%
cn.close();
%>