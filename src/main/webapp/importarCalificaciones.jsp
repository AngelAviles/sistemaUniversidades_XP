<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="dao.PlandeestudioJpaController"%>
<%@page import="objetosNegocio.Plandeestudio"%>
<%@page import="jwt.JWT"%>
<%@page import="java.util.ArrayList"%>
<%@page import="objetosNegocio.Alumno" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    List<Plandeestudio> listaPlanesEstudio = new ArrayList<>();
    
    EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
    PlandeestudioJpaController planEstudioDAO = new PlandeestudioJpaController(factory);
    listaPlanesEstudio = planEstudioDAO.findPlandeestudioEntities();

    
    List<Alumno> calificacionesRegistradas = new ArrayList<Alumno>();
    List<Integer> camposVacios = new ArrayList<Integer>();
    List<Integer> calificacionesPreexistentes = new ArrayList<Integer>();
    List<Integer> matriculaIncorrecta = new ArrayList<Integer>();
    List<Integer> claveMateriaIncorrecta = new ArrayList<Integer>();
    List<Integer> calificacionesIncorrectas = new ArrayList<Integer>();

    Boolean archivoInvalido = false;

    /*
    if (JWT.validarJWT(request, response)) {

        List[] lista = (List[]) session.getAttribute("listaCalificaciones");
        session.removeAttribute("listaCalificaciones");

        if ((Boolean) session.getAttribute("archivoInvalido") != null) {
            archivoInvalido = (Boolean) session.getAttribute("archivoInvalido");
            session.removeAttribute("archivoInvalido");
        }

        if (lista != null) {
            calificacionesRegistradas = lista[0];
            camposVacios = lista[1];
            calificacionesPreexistentes = lista[2];
            matriculaIncorrecta = lista[3];
            claveMateriaIncorrecta = lista[4];
            calificacionesIncorrectas = lista[5];
        }
    } else {
        session = request.getSession();
        session.removeAttribute("token");
        response.sendRedirect("inicioSesion.jsp");

    }
     */
%>
<!DOCTYPE html>
<html>

    <head>
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
        <title>Importar Calificaciones</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.24/datatables.min.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>

    <body>
        <article>
            <h1 class="text-center">Importar Calificaciones</h1>

            <hr />

            <hr />

            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-auto">
                        <div class="border border-black border-3 mb-3">
                            <form action="importarCalificaciones" method="post" enctype="multipart/form-data">
                                <div class="m-3">
                                    <label for="formFileSm" class="form-label">Archivo Excel o
                                        CSV</label>
                                    <div class="row m-auto">
                                        <input class="form-control form-control-sm col" id="formFileSm" name="archivo"
                                               type="file" accept=".xls, .xlsx, .csv" required/>
                                        <i class="fa fa-question-circle col-sm-auto" title="Formato del archivo"
                                           data-bs-content="El archivo debe contener la información de las calificaciones ordenados de la siguiente manera: matricula del alumno y el resto seran las claves de las materias . Puedes utilizar esta <a href='recursos/plantilla_importar_calificaciones.xlsx' download='Plantilla de Importar Calificaciones.xlsx'>plantilla</a>." data-bs-toggle="popover" data-bs-html="true" ></i>
                                    </div>
                                </div>
                                <div class="m-3">
                                    <div class="d-grid gap-6 mx-auto">
                                        <button class="btn btn-secondary" type="reset">Eliminar</button>
                                    </div>
                                </div>

                                <div class="m-3 mt-5">
                                    <div class="d-grid gap-6 mx-auto">

                                        <button class="btn btn-primary" type="submit" name="accion" value="importarCalificaciones">Importar</button>

                                    </div>
                                </div>

                            </form>
                            <div class="m-3">
                                <div class="d-grid gap-6 mx-auto">
                                    <button class="btn btn-danger" onclick="location.href = 'administrarAlumnos.jsp'">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive col-md">
                        <table id="calificacionesTabla" class="table table-striped border border-black border-3">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">Matricula</th>
                                    <th scope="col">Materia 1</th>
                                    <th scope="col">Materia 2</th>
                                    <th scope="col">Materia 3</th>
                                    <th scope="col">Materia 4</th>
                                    <th scope="col">Materia 5</th>
                                    <th scope="col">Materia 6</th>
                                    <th scope="col">Materia 7</th>
                                    <th scope="col">Materia 8</th>
                                </tr>
                            </thead>
                            <tbody>

                                <% if (false) {
                                        for (int i = 0; i < 10; i++) {
                                            out.print("<tr>"
                                                    + "<td scope=\"row\">" + 187962 + "</td>"
                                                    + "<td>" + 9 + "</td>"
                                                    + "<td>" + 9 + "</td>"
                                                    + "<td>" + 8 + "</td>"
                                                    + "<td>" + 7 + "</td>"
                                                    + "<td>" + 8 + "</td>"
                                                    + "<td>" + 7 + "</td>"
                                                    + "<td>" + 10 + "</td>"
                                                    + "<td>" + 9 + "</td>"
                                                    + "</tr>"
                                            );
                                        }
                                    } else {
                                        out.print("<tr>"
                                                + "<td scope=\"row\">187962</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "<td>10</td>"
                                                + "</tr>");
                                    }

                                %>

                            </tbody>
                        </table>
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
