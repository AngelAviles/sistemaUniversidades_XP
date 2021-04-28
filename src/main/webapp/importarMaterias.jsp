<%@page import="jwt.JWT"%>
<%@page import="objetosNegocio.Materia"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    List<Materia> materiasRegistrados = new ArrayList<Materia>();
    
    if (JWT.validarJWT(request, response)) {
        List<Materia> lista = (List) session.getAttribute("listaMaterias");
        session.removeAttribute("listaMaterias");

        if (lista != null) {
            materiasRegistrados = lista;
        }
    } else {
        session = request.getSession();
        session.removeAttribute("token");
        response.sendRedirect("inicioSesion.jsp");
    }
%>

<!DOCTYPE html>
<html>

    <head>
        <title>Importar Materias</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.24/datatables.min.css"/>
        <link href="estilos/estilos.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    </head>

    <body>
        <article>
            <h1 class="text-center">Importar Materias</h1>

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

            <div class="d-flex flex-row">
                <div class="d-flex row align-items-center justify-content-center w-100">
                    <div class="col-sm-5">
                        <form action="importarMaterias" method="post">
                            <div class="border border-black border-3 mb-3">
                                <div class="m-3">
                                    <label for="claveMateria" class="form-label">Clave</label>
                                    <input class="form-control form-control-sm col" id="claveMateria" name="clave" type="text" required/>
                                </div>
                                <div class="m-3">
                                    <label for="nombreMateria" class="form-label">Materia</label>
                                    <input class="form-control form-control-sm col" id="nombreMateria" name="nombre" type="text" required/>
                                </div>
                                <div class="m-3">
                                    <h6>SerializaciÃ³n</h6>
                                    <div class="p-auto border border-black border-2">
                                        <label for="materiaSeriada" class="form-label mx-3 mt-3">Materia</label>
                                        <div class="row col mx-3 align-items-center">
                                            <select id="materiaSeriada" class="form-select form-select-sm col" aria-label=".form-select-sm example">
                                                <option selected>Selecciona una materia</option>
                                                <% if (!materiasRegistrados.isEmpty()) {
                                                        for (int i = 0; i < 10; i++) {
                                                            out.print("<option value=\"" + 1 + "\">" + materiasRegistrados.get(i) + "</option>");
                                                        }
                                                    } else {
                                                        out.print("<option value=\"1\">One</option>"
                                                                + "<option value=\"2\">Two</option>"
                                                                + "<option value=\"3\">Three</option>");
                                                    }
                                                %>
                                            </select>
                                            <button class="btn btn-default col-sm-auto col-auto" type="button">
                                                <span class="fa fa-plus-square" aria-hidden="true"></span>
                                            </button>
                                        </div>
                                        <div class="d-flex row m-3 border border-black border-2 row-cols-2 align-items-center">
                                            <i class="fa fa-minus-square my-2 col-auto" aria-hidden="true"></i>
                                            <div class="my-2 col flex-grow-1">Materia 1 (Clave 1)</div>
                                            <%
                                                if (!materiasRegistrados.isEmpty()) {
                                                    for (Materia materiasRegistrado : materiasRegistrados) {
                                                        out.print("<i class=\"fa fa-minus-square my-2 col-auto\" aria-hidden=\"true\"></i>");
                                                        out.print("<div class=\"my-2 col\">" + materiasRegistrado.getNombre() + " (" + materiasRegistrado.getClave() + ")</div>");
                                                    }
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-3">
                                    <div class="d-grid gap-6 mx-auto">
                                        <button class="btn btn-secondary" type="reset">Limpiar</button>
                                    </div>
                                </div>
                            </div>
                            <div class="m-3 mt-5">
                                <div class="d-grid gap-6 mx-auto">
                                    <button class="btn btn-primary" type="submit">Importar</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="table-responsive col h-100 d-flex flex-column">
                        <div class="row flex-grow-1">
                            <table id="alumnosTabla" class="table table-striped border border-black border-3">
                                <thead class="table-dark">
                                    <tr>
                                        <th scope="col">Clave</th>
                                        <th scope="col">Nombre</th>
                                        <th scope="col">Materias seriadas</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <% if (!materiasRegistrados.isEmpty()) {
                                            for (int i = 0; i < materiasRegistrados.size(); i++) {
                                                Materia a = (Materia) materiasRegistrados.get(i);
                                                out.print("<tr>"
                                                        + "<td scope=\"row\">" + a.getClave() + "</td>"
                                                        + "<td>" + a.getNombre() + "</td>"
                                                        + "<td>");

                                                for (int j = 0; j < a.getMateriasSeriadas().size(); j++) {
                                                    if (j == 0) {
                                                        out.print(a.getMateriasSeriadas().get(i).getMateria().getNombre());
                                                    } else {
                                                        out.print(", " + a.getMateriasSeriadas().get(i).getMateria().getNombre());
                                                    }
                                                }
                                                out.print(".</td>"
                                                        + "</tr>"
                                                );
                                            }
                                        } else {
                                            out.print("<tr>"
                                                    + "<td scope=\"row\">Clave 1</td>"
                                                    + "<td>Materia 1</td>"
                                                    + "<td>Materia Seriada 1, Materia Seriada 2</td>"
                                                    + "</tr>");
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <div class="m-3 row">
                            <div class="d-grid justify-content-md-end">
                                <button class="btn btn-danger me-md-2" onclick="history.back()">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>            
        </article>

        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.24/datatables.min.js"></script>
        <script src="js/app.js" charset="utf-8"></script>
    </body>

</html>
