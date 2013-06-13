

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="Conexion.Conectar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="Usuario.Data" scope="session"/>
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
            String nbre, apell, aux, contraseña,usu, tel;
            String doc;
            
            
            if (resp.equals("OK")){
               
             nbre=request.getParameter("nombre");
             apell=request.getParameter("apellido");
             //aux=request.getParameter("dni");
             doc= request.getParameter("dni");
             contraseña=request.getParameter("pass");
             usu=request.getParameter("usuario");
             tel=request.getParameter("telefono");
             Statement consulta = conn.Consulta();
             String sql = "SELECT * FROM personas WHERE dni = '" + doc + "'";
             ResultSet rs=consulta.executeQuery(sql);
             boolean tiene = rs.next();
            
             if(tiene==false)
             {
             
                String q ="INSERT INTO personas VALUES ('"+ nbre +"','"+ apell+"',"+ doc +",'"+ usu +"','"+ contraseña+"','"+tel+"')";
                consulta.executeUpdate(q);
                
                user.setUsername(usu);
                user.setPassword(contraseña);
                user.setNombre(nbre);
                user.setApellido(apell);
                user.setDni(doc);
                user.setTel(tel);
                
                response.sendRedirect("index.jsp");
                          
             }            
                      %>
                      <script>alert("el usuario ya existe");</script>
                   <%  
            }
        
        
   
        %>
    </body>
</html>
