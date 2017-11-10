<%@ page import="{{reversed_domain}}.Widget" %>
<html>
<head>
<title>Hello from {{project_name}}!</title>
</head>
<body>
    <h1>Hello from {{project_name}}!</h1>
    <p>
        It is now
        <%= new java.util.Date() %></p>
    <p>
        You are coming from
        <%= request.getRemoteAddr() %></p>
    <p>
        Widget:
        <%= new Widget().join("aaa", "bbb") %></p>
</body>
