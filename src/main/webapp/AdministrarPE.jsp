<%@page import="dao.MateriaJpaController"%>
<%@page import="objetosNegocio.Materia"%>
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
    List<Materia> listaMaterias = new ArrayList<>();

    if (JWT.validarJWT(request, response)) {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
        MateriaJpaController materiaDAO = new MateriaJpaController(factory);
        listaMaterias = materiaDAO.findMateriaEntities();

        // request.setAttribute("listaUsuarios", listaUsuarios);
    } else {
        session = request.getSession();
        session.removeAttribute("token");
        response.sendRedirect("inicioSesion.jsp");
        request.getRequestDispatcher("inicioSesion.jsp").forward(request, response);
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.24/datatables.min.css"/>
        <title>Administrar Planes de Estudio</title>
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    </head>
    <body>
        <h1 class="text-center">Administrar Planes de Estudio</h1>
        <hr />
        <hr />

        <div class="container mt-12 col-lg-12">
            <div class="col-lg-12 card mx-2">
                <div class="card-body">
                    <form class="form" action="ControlServlet" method="POST">
                        <div class="form-group">                    
                            <div class="mb-4 row">                         
                                <label class="col-sm-3 col-form-label" align="center">Nombre del plan de estudio:</label>
                                <div class="col-sm-8">
                                    <input minlength="1" maxlength="40" type="text" name="txtNombrePlan" class="form-control" placeholder="Introduzca el nombre del plan de estudio" required="">
                                </div>
                            </div>
                            <div class="col-lg-12 card table-responsive">
                                <div class="card-body" style="">
                                    <table class="table table-striped border border-black border-3" id="planesTabla">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Semestre</th>
                                                <th>Materia 1</th>
                                                <th>Materia 2</th>
                                                <th>Materia 3</th>
                                                <th>Materia 4</th>
                                                <th>Materia 5</th>
                                                <th>Materia 6</th>
                                                <th>Materia 7</th>
                                                <th>Materia 8</th>
                                            </tr>
                                        </thead>
                                        <tbody>       
                                            <tr>
                                                <td>Semestre 1</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat1" onclick="">
                                                            <option disabled="disabled" selected="true" value="" required>Seleccione materia</option> 
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem1mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Semestre 2</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat1">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem2mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Semestre 3</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat1">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem3mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Semestre 4</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat1">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem4mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Semestre 5</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat1">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem5mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td>Semestre 6</td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat1">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat2">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat3">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat4">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat5">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat6">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat7">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>    
                                                    <div class="col-sm-auto">
                                                        <select class="form-select" name="sem6mat8">
                                                            <%
                                                                for (int i = 0; i < listaMaterias.size(); i++) {
                                                                    out.print("<option value=\"" + listaMaterias.get(i).getNombre() + "\">" + listaMaterias.get(i).getNombre() + "</option>");
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </td>
                                            </tr>                                          
                                            
                                        </tbody>
                                    </table> 
                                </div>
                            </div>
                            <br>
                            <div class="mb-3 row">
                                <div class="col-sm-6" align="center">
                                    <button type="submit" name="accion" value="crearPlan" class="btn btn-success">Crear plan</button>
                                </div>

                                <div class="col-sm-6" align="center">
                                    <button class="btn btn-danger" onclick="location.href = 'menuPrincipal.jsp'">Cancelar</button>
                                </div>

                            </div>

                        </div>           
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>