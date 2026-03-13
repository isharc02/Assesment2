<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - SimpleBlog</title>
        <!-- Google Fonts: Inter -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            :root {
                --primary-color: #4f46e5;
                --secondary-color: #6366f1;
                --bg-color: #f8fafc;
                --text-color: #1e293b;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            main {
                flex: 1;
            }

            .blog-card {
                background: #ffffff;
                border: none;
                border-radius: 16px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
                height: 100%;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            .blog-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 30px -5px rgba(0, 0, 0, 0.1);
            }

            .blog-card-body {
                padding: 1.5rem;
                flex-grow: 1;
                display: flex;
                flex-direction: column;
            }

            .blog-card-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #0f172a;
                margin-bottom: 0.75rem;
                text-decoration: none;
                transition: color 0.2s;
            }

            .blog-card-title:hover {
                color: var(--primary-color);
            }

            .blog-card-text {
                color: #64748b;
                font-size: 0.95rem;
                line-height: 1.6;
                margin-bottom: 1.25rem;
                flex-grow: 1;
            }

            .tag-badge {
                background-color: rgba(79, 70, 229, 0.1);
                color: var(--primary-color);
                font-weight: 600;
                font-size: 0.75rem;
                padding: 0.4em 0.8em;
                border-radius: 50rem;
                text-decoration: none;
                transition: all 0.2s ease;
                display: inline-block;
                margin-bottom: 1rem;
            }

            .tag-badge:hover {
                background-color: var(--primary-color);
                color: white;
            }

            .blog-meta {
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-top: 1px solid #f1f5f9;
                padding-top: 1rem;
                margin-top: auto;
            }

            .author-info {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: #475569;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .author-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background-color: #e2e8f0;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #64748b;
                font-weight: bold;
                font-size: 0.8rem;
            }

            .read-more-btn {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 0.9rem;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.25rem;
                transition: gap 0.2s;
            }

            .read-more-btn:hover {
                gap: 0.5rem;
            }

            .sidebar-widget {
                background: #ffffff;
                border-radius: 16px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
                margin-bottom: 1.5rem;
            }

            .widget-title {
                font-size: 1.1rem;
                font-weight: 700;
                color: #0f172a;
                margin-bottom: 1.25rem;
                position: relative;
                padding-bottom: 0.5rem;
            }

            .widget-title::after {
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                width: 40px;
                height: 3px;
                background-color: var(--primary-color);
                border-radius: 3px;
            }

            .form-control {
                border-radius: 10px;
                padding: 0.6rem 1rem;
                background-color: #f8fafc;
                border: 1px solid #e2e8f0;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(79, 70, 229, 0.15);
                background-color: #ffffff;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                border-radius: 10px;
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }

            .recent-post-item {
                display: flex;
                gap: 1rem;
                margin-bottom: 1rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #f1f5f9;
            }

            .recent-post-item:last-child {
                margin-bottom: 0;
                padding-bottom: 0;
                border-bottom: none;
            }

            .recent-title {
                font-size: 0.95rem;
                font-weight: 600;
                color: #1e293b;
                text-decoration: none;
                display: block;
                margin-bottom: 0.25rem;
                transition: color 0.2s;
            }

            .recent-title:hover {
                color: var(--primary-color);
            }

            .recent-date {
                font-size: 0.75rem;
                color: #94a3b8;
            }

            .tag-cloud a {
                display: inline-block;
                background: #f1f5f9;
                color: #475569;
                padding: 0.4rem 0.8rem;
                border-radius: 8px;
                font-size: 0.8rem;
                font-weight: 500;
                text-decoration: none;
                margin: 0 0.3rem 0.5rem 0;
                transition: all 0.2s;
            }

            .tag-cloud a:hover {
                background: var(--primary-color);
                color: white;
            }
        </style>
            <style>
        .navbar-nav .nav-link {
            color: #475569;
            transition: color 0.2s ease;
        }

        .navbar-nav .nav-link:hover {
            color: #4f46e5;
        }

        .navbar-nav .btn.nav-link:hover {
            background-color: #fee2e2 !important;
            color: #dc2626 !important;
        }
    </style>
    </head>

    <body>
    
<!-- header -->
         <nav class="navbar navbar-expand-lg sticky-top shadow-sm"
        style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);">
        <div class="container">
            <a class="navbar-brand fw-bold" href="dashboard.jsp"
                style="color: #4f46e5; font-size: 1.4rem; letter-spacing: -0.5px;">
                <i class="fa-solid fa-pen-nib me-2"></i>SimpleBlog
            </a>
            <button class="navbar-toggler border-0 shadow-none" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 fw-medium">
                    <li class="nav-item">
                        <a class="nav-link px-3" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="#">Create Post</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="search.jsp">Search</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link px-3" href="#">Profile</a>
                    </li>
                    <li class="nav-item ms-lg-2">
                        <a class="nav-link btn btn-light rounded-pill px-3 text-danger fw-semibold" href="login.jsp"
                            style="background-color: #fff0f0;">
                            <i class="fa-solid fa-arrow-right-from-bracket me-1"></i>Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
<!-- container -->
<main class="py-5">
                <div class="container">
                    <div class="row g-4">
                        <!-- Main Feed -->
                        <div class="col-lg-8">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h2 class="fw-bold m-0" style="color: #0f172a; letter-spacing: -0.5px;">Latest Posts
                                </h2>
                                <span class="text-muted">Showing 5 of 24 posts</span>
                            </div>

                            <div class="row g-4">
                                <!-- Blog Card 1 -->
                                
<%
Connection cn = new DBUtil().getConnectionData();
String qry = "SELECT blogs.*, users.name FROM blogs JOIN users ON blogs.uid = users.uid";
PreparedStatement st = cn.prepareStatement(qry);
ResultSet rs = st.executeQuery();

while(rs.next())
{
String context = rs.getString(4);

String shortContext = context.length() > 120 
        ? context.substring(0,120) + "..." 
        : context;
%>

<div class="col-md-6">
<div class="blog-card">
<div class="blog-card-body">

<a href="search.jsp?tag=<%=rs.getString(5)%>" class="tag-badge">
<%=rs.getString(5)%>
</a>

<!-- Title -->
<form action="ViewPostController" method="post">

<input type="hidden" name="action" value="view">
<input type="hidden" name="id" value="<%=rs.getInt(1)%>">

<button type="submit" 
style="border:none;background:none;padding:0;text-align:left"
class="blog-card-title d-block">

<%=rs.getString(3)%>

</button>

</form>

<!-- Short Content -->
<p class="blog-card-text">
<%=shortContext%>
</p>

<div class="blog-meta">

<div class="author-info">

<div>
<div><%=rs.getString("name")%></div>

<div class="text-muted" style="font-size: 0.75rem;">
<%=rs.getString(6)%>
</div>

</div>

</div>

<!-- Read Button -->
<form action="ViewPostController" method="post">

<input type="hidden" name="action" value="view">
<input type="hidden" name="id" value="<%=rs.getInt(1)%>">

<button type="submit" 
class="read-more-btn"
style="border:none;background:none">

Read <i class="fa-solid fa-arrow-right"></i>

</button>

</form>

</div>

</div>
</div>
</div>

<%
}
cn.close();
%>





                            </div>

                            <!-- Pagination -->
                            <nav class="mt-5">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item disabled">
                                        <a class="page-link border-0 rounded-circle me-2"
                                            style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"
                                            href="#" tabindex="-1"><i class="fa-solid fa-chevron-left"></i></a>
                                    </li>
                                    <li class="page-item active"><a class="page-link border-0 rounded-circle me-2"
                                            style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; background-color: var(--primary-color);"
                                            href="#">1</a></li>
                                    <li class="page-item"><a
                                            class="page-link border-0 rounded-circle me-2 text-dark bg-white shadow-sm"
                                            style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"
                                            href="#">2</a></li>
                                    <li class="page-item"><a
                                            class="page-link border-0 rounded-circle me-2 text-dark bg-white shadow-sm"
                                            style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"
                                            href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link border-0 rounded-circle text-dark bg-white shadow-sm"
                                            style="width: 40px; height: 40px; display: flex; align-items: center; justify-content: center;"
                                            href="#"><i class="fa-solid fa-chevron-right"></i></a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <!-- Right Sidebar -->
                        <div class="col-lg-4">


                            <!-- Recent Posts Widget -->
                            <div class="sidebar-widget">
<h4 class="widget-title">Recent Posts</h4>

<div class="recent-posts">

<%
Connection cn2 = new DBUtil().getConnectionData();

String recentQry = "SELECT id,title,createdat FROM blogs ORDER BY createdat DESC LIMIT 3";

PreparedStatement pst = cn2.prepareStatement(recentQry);

ResultSet rrs = pst.executeQuery();

while(rrs.next())
{
%>

<div class="recent-post-item">
<div>

<form action="ViewPostController" method="post">

<input type="hidden" name="action" value="view">
<input type="hidden" name="id" value="<%=rrs.getInt("id")%>">

<button type="submit"
style="border:none;background:none;padding:0;text-align:left"
class="recent-title">

<%=rrs.getString("title")%>

</button>

</form>

<span class="recent-date">
<%=rrs.getTimestamp("createdat")%>
</span>

</div>
</div>

<%
}
cn2.close();
%>

</div>
</div>
                           
                            <!-- Tags Widget -->
<div class="sidebar-widget"> 
<h4 class="widget-title">Popular Tags</h4>

<div class="tag-cloud">

<%
Connection cn3 = new DBUtil().getConnectionData();

String tagQry = "SELECT tags, COUNT(tags) as total FROM blogs GROUP BY tags ORDER BY total DESC LIMIT 7";

PreparedStatement pstTag = cn3.prepareStatement(tagQry);

ResultSet tagRs = pstTag.executeQuery();

while(tagRs.next())
{
String tag = tagRs.getString("tags");
String encodedTag = java.net.URLEncoder.encode(tag,"UTF-8");
%>

<a href="search.jsp?tags=<%=encodedTag%>">
<%=tag%>
</a>

<%
}
cn3.close();
%>

</div>
</div>

                        </div>
                    </div>
                </div>
            </main>


<!-- footer -->
            <footer class="py-4 mt-auto border-top shadow-sm" style="background-color: white;">
        <div class="container text-center">
            <p class="text-muted mb-0 fw-medium small">© 2026 SimpleBlog - Built with JSP & Servlets</p>
        </div>
    </footer>
    <!-- Bootstrap 5 JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>