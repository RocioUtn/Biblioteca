<%-- 
    Document   : bien
    Created on : 28/05/2013, 15:56:52
    Author     : Fede
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="Usuario.Data" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>
            <%=user.getUsername()%>
        </h1>
    </body>
</html>
