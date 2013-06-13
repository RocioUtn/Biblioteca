<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.Conectar"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function Validar()
            {
                if(document.getElementById("libro").value == "")
                    {
                        alert("Debe completar el campo de búsqueda.");
                        return false;
                    }
                    return true;
            }
        </script>
    </head>
    <body>
         <div>
             <form name="form" action="Buscar.jsp" method="post">
             <input name="libro" id="libro" size="60" type="text" value=""/>
             <input type="submit" value="Buscar">
            </form>
        </div>
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
                while(rs.next())
                {
                 out.println(rs.getString("titulo")+", "+rs.getString("autor")+" <a href='ReservarLibro.jsp?isbn="+rs.getString("isbn")+"'>Reservar</a><br>");
                }
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
    </body>
</html>
