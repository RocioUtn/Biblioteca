<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.Conectar"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="Usuario.Data" scope="session"/>
<%
    boolean busca = false;
    String libr = " ";
    if(request.getParameter("libro")!=null)
     {
         busca = true;
         libr=request.getParameter("libro");
     }
              
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>

<script>
function ValidarB()
{
	if(document.getElementById("libro").value == "")
		{
			alert("Debe completar el campo de búsqueda.");
			return false;
		}
		return true;
}
function ValidarI()
{
	if(document.getElementById("username") == "")
	{
		alert("Debe completar el nombre de usuario.");
		return false;
	}
	if(document.getElementById("password") == "")
	{
		alert("Debe completar la contraseña del usuario.");
		return false;
	}
	return true;
}
</script>
<style>
#TablaResultados tr:nth-child(odd) {
   background-color: #FFC;
   color:#777
}

#TablaResultados tr:nth-child(even) {
   background-color: #FC9;
   color:#777;
}
</style>
<link href="estilo.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="container">
  <div class="header" align="center">
  	<h1 style="padding-top:10px; margin-bottom:-5px">SOReLTe</h1>
	Sistema Online de Reserva de Libros de la Tecnologica
  </div>
  <div class="sidebar1" align="center">
    <%
    String usu=user.getUsername();
              
    if (usu==null)
    {    
    %>
    <form action="Validar.jsp" method="post" onsubmit="return ValidarI()">
    <ul class="nav">
      <li>Usuario:<br /><input name=username size="30" id="username" type="text"/></li>
      <li>Contrase&ntilde;a:<br /><input name=password size="30" id="password" type="password"/></li>
      <li><input type="submit" value="Enviar"></li>
      <li><input type="button" name="boton1" value="Registrarse" onclick="JavaScript:location.href='registro.html'"></li>
    </ul>
    </form>
    <%
    }
    else
    {
    %>
    <ul class="nav">
      <li> <%=user.getUsername()%> </li>
      <li><a href="#">Modificar mis datos</a></li>
      <li><a href="#">Cerrar Sesi&oacute;n</a></li>
    </ul>
    <%
    }
    %>
  </div>
  <div class="content" align="center">
	<form name="form" action="index.jsp" method="post" onsubmit="return ValidarB()">
    <table width="100%" border="0" cellpadding="0">
      <tr>
        <td align="center"><input name="libro" id="libro" size="80" type="text" value=""/></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" value="Buscar"></td>
      </tr>
      <tr>
        <td height="15"></td>
      </tr>
      <tr>
      <td align="center">
<%
    if(busca)
    {
        Conectar conn = new Conectar();
        String resp = conn.Conectar();
        
        if (resp.equals("OK"))
        {
            libr = libr.replaceAll(" ", "%").toLowerCase();
             
            Statement consulta = conn.Consulta();
            
            String sql = "SELECT * FROM libros WHERE titulo LIKE '%" + libr + "%' OR autor LIKE '%"+ libr +"%' OR editorial LIKE '%"+ libr +"%' OR isbn='"+ libr +"' ";
            //out.println(sql);
            ResultSet rs=consulta.executeQuery(sql);
             
            if(!rs.isBeforeFirst())
            {
                %>
                <script>alert('No se encontraron resultados.');</script>
                <%
            }
            else
            {
                %>
                <table width="90%" border="0" cellpadding="0" id="TablaResultados">
                    <tr style="background-color:#000; color:#FFF">
                    <td width="43%" align="center">
                      T&iacute;tulo 
                    </td>
                    <td width="43%" align="center">
                      Autor
                    </td>
                    <td width="14%" align="center">
                      &nbsp;
                    </td>
                    </tr>
                <%
                while(rs.next())
                {
                %>
                <tr>
                    <td align="center"><%=rs.getString("titulo")%></td>
                    <td align="center"><%=rs.getString("autor")%></td>
                    <td align="center"><a href='ReservarLibro.jsp?isbn=<%=rs.getString("isbn")%>'>Reservar</a></td>
                </tr>
                <%
                }
                %>
                </table>
                <%
            }
            
        }
        else  
        {
            %>
            <script>
               alert("Conexion fallida"); 
            </script>

            <% 
         }   
    }
%>
      </td>
      </tr>
    </table>
    </form>
  </div>
  <div class="footer" align="center">
    <span style="font-size:10px"><b>Trabajo Final Java - UTN - FRRO</b><br />
    Alvarez, Federico - Muccini, Ver&oacute;nica</span>
  </div>
</div>
</body>
</html>
