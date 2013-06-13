<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Conexion.Conectar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="Usuario.Data" scope="session"/>
<jsp:setProperty name="user" property="*"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         Conectar conn = new Conectar();
         String resp = conn.Conectar();
           
            if (resp.equals("OK"))
            {
                
                String usu=user.getUsername();
                Statement consulta = conn.Consulta();
                String sql="SELECT * FROM reservas r, libros l WHERE r.isbn=l.isbn AND usuario='"+usu+"' AND fecha_desde=CURDATE()";
                ResultSet rs=consulta.executeQuery(sql);
                
               
                while(rs.next())
                {
                  out.println(rs.getString("titulo")+", "+rs.getString("autor")+", "+rs.getString("genero")+", "+rs.getString("sinopsis")+" <a href='ELiminarReserva.jsp?isbn="+rs.getString("isbn")+"'>Eliminar</a><br>");
             

                }
                
            }
    %>
    </body>
</html>
