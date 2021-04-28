<%-- 
    Document   : registroUsuario
    Created on : 18/04/2021, 05:34:06 PM
    Author     : Luis Osuna
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="jwt.JWT"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.UsuarioJpaController"%>
<%@page import="dao.EscuelaJpaController"%>
<%@page import="objetosNegocio.Usuario"%>
<%@page import="objetosNegocio.Escuela"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    List<Usuario> listaUsuarios = new ArrayList<>();
    List<Escuela> listaEscuelas = new ArrayList<>();

    if (JWT.validarJWT(request, response)) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
        UsuarioJpaController usuarioDAO = new UsuarioJpaController(factory);
        listaUsuarios = usuarioDAO.findUsuarioEntities();
        request.setAttribute("listaUsuarios", listaUsuarios);
        EscuelaJpaController escuelaDAO = new EscuelaJpaController(factory);
        listaEscuelas = escuelaDAO.findEscuelaEntities();
    } else {
        session = request.getSession();
        session.removeAttribute("token");
        response.sendRedirect("inicioSesion.jsp");
        //request.getRequestDispatcher("inicioSesion.jsp").forward(request, response);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <title>Administrar usuarios</title>
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    </head>
    <body>
        <div class="container mt-5 col-lg-12">
            <div class="row">
                <div class="col-lg-4 card mx-2">
                    <div class="card-body">
                        <h3 align="center">Registro de Usuario</h3>
                            <div class="form-group">          
                                <form class="form" action="ControlServlet" method="POST"> 
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">CURP:</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="txtCurp" class="form-control" placeholder="Introduzca la Curp">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Nombre:</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="txtNombre" class="form-control" placeholder="Introduzca el nombre">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Apellidos:</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="txtapellidos" class="form-control" placeholder="Introduzca los apellidos">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Fecha de nacimiento:</label>
                                        <div class="col-sm-6">
                                            <input type="date" name="fecha" class="form-control">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <div class="col-sm-6">  
                                            <label> Actividad: </label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioActividad" id="radioActivo" value="Activo">
                                                <label class="form-check-label" for="radioActivo" value="Activo">
                                                    Activo
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioActividad" id="radioInactivo" value="Inactivo">
                                                <label class="form-check-label" for="radioInactivo" value="Inactivo">
                                                    Inactivo
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-6" >  
                                            <label> Sexo: </label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioSexo" id="radioHombre" value="Masculino">
                                                <label class="form-check-label" for="radioHombre" value="Masculino">
                                                    Masculino
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioSexo" id="radioMujer" value="Femenino">
                                                <label class="form-check-label" for="radioMujer" value="Femenino">
                                                    Femenino
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Usuario:</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="txtUsuario" class="form-control" placeholder="Introduzca el usuario">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Contraseña:</label>
                                        <div class="col-sm-8">
                                            <input type="text" name="txtPassword" class="form-control" placeholder="Introduzca la contraseña">
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Escuela de pertenencia:</label>
                                        <div class="col-sm-8">
                                            <select class="form-select" name="escuela">                                           
                                                <%
                                                    for (int i = 0; i < listaEscuelas.size(); i++) {
                                                        out.print("<option value=\"" + listaEscuelas.get(i).getNombre() + "\">" + listaEscuelas.get(i).getNombre() + "</option>");
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <label class="col-sm-4 col-form-label">Tipo de usuario:</label>
                                        <div class="col-sm-8">
                                            <select class="form-select" name="tipoUsuario">
                                                <option value="Administrador">Administrador</option>
                                                <option value="Personal">Personal</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3 row">
                                        <button type="submit" name="accion" value="registrarUsuario" class="btn btn-success">Registrar Usuario</button>
                                    </div>
                                </form>
                            <div class="mb-3 row">
                                <button class="btn btn-danger" onclick="location.href='menuPrincipal.jsp'">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7 card">
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>CURP</th>
                                    <th>Nombre</th>
                                    <th>Apellidos</th>
                                    <th>Fecha de Nacimiento</th>
                                    <th>Sexo</th>
                                    <th>Actividad</th>
                                    <th>Escuela</th>
                                </tr>
                            </thead>
                            <tbody>                                
                                <tr>
                                    <%
                                        for (int i = 0; i < listaUsuarios.size(); i++) {
                                            String nuevoActivo = null;
                                            if (listaUsuarios.get(i).getActivo() == true) {
                                                    nuevoActivo = "Activo";
                                                }else{
                                                nuevoActivo = "Inactivo";
                                            }
                                            out.print("<tr>"
                                                    + "<td scope=\"row\">" + listaUsuarios.get(i).getCurp() + "</td>"
                                                    + "<td>" + listaUsuarios.get(i).getNombre() + "</td>"
                                                    + "<td>" + listaUsuarios.get(i).getApellido() + "</td>"
                                                    + "<td>" + new SimpleDateFormat("dd-MM-yyyy").format(listaUsuarios.get(i).getFecha()) + "</td>"
                                                    + "<td>" + listaUsuarios.get(i).getSexo() + "</td>"
                                                    + "<td>" + nuevoActivo + "</td>"
                                                    + "<td>" + listaUsuarios.get(i).getEscuela() + "</td>"
                                                    + "</tr>"
                                            );
                                        }
                                    %>
                                </tr>
                            </tbody>
                        </table> 
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
