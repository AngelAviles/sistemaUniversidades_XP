<%-- 
    Document   : importarAlumnos
    Created on : 12/04/2021, 09:46:32 PM
    Author     : angel
--%>

<%@page import="objetosNegocio.Alumno"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List lista = (List) session.getAttribute("listaAlumnos");
    session.removeAttribute("listaAlumnos");
%>

<!DOCTYPE html>
<html>

    <head>
        <title>Importar Alumnos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>

    <body>
        <article>
            <h1 class="text-center">Importar Alumnos</h1>

            <hr />
            <nav>
                <ul class="nav justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link" href="#">Escuelas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Capturistas</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Alumnos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Calificaciones</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Kardex</a>
                    </li>
                </ul>
            </nav>
            <hr />

            <div class="container-fluid ">
                <div class="row align-items-center justify-content-center">
                    <div class="col-auto">
                        <div class="border border-black border-3 mb-3">
                            <form action="importarAlumnos" method="post" enctype="multipart/form-data">
                                <div class="m-3">
                                    <label for="formFileSm" class="form-label">Archivo Excel o CSV</label>
                                    <input class="form-control form-control-sm" id="formFileSm" name="archivo" type="file" <%--accept=".xls, .xlsx, .csv"--%> >
                                </div>
                                <div class="m-3">
                                    <div class="d-grid gap-6 mx-auto">
                                        <button class="btn btn-secondary" type="reset">Eliminar</button>
                                    </div>
                                </div>
                                <div class="m-3 mt-5">
                                    <div class="d-grid gap-6 mx-auto">
                                        <button class="btn btn-danger">Cancelar</button>
                                    </div>
                                </div>
                                <div class="m-3">
                                    <div class="d-grid gap-6 mx-auto">
                                        <button class="btn btn-primary" type="submit">Importar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="table-responsive col-md">
                        <table class="table table-striped border border-black border-3" id="alumnosTabla">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">CURP</th>
                                </tr>
                            </thead>
                            <tbody>

                                <%
                                    if (lista != null) {
                                        for (int i = 0; i < lista.size(); i++) {
                                            Alumno a = (Alumno) lista.get(i);
                                            out.print("<tr>"
                                                    + "<td scope=\"row\">" + a.getMatricula() + "</td>"
                                                    + "<td>" + a.getNombre() + "</td>"
                                                    + "<td>" + a.getCurp() + "</td>"
                                                    + "<tr>"
                                            );
                                        }
                                    } else {
                                        out.print("<tr>"
                                                + "<td scope=\"row\">1</td>"
                                                + "<td>Angel</td>"
                                                + "<td>curp</td>"
                                                + "<tr>"
                                        );
                                    }


                                %>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </article>
    </body>
</html>