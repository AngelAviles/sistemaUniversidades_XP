<%@page import="jwt.JWT"%>
<%@page import="objetosNegocio.Escuela"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (JWT.validarJWT(request, response)) {

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
        <title>Registrar Escuelas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    </head>
    
    <body>
        <article>
            <h1 class="text-center">Registrar Escuelas</h1>

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

            <div class="container-fluid">
                <div class="row align-items-center justify-content-center">
                    <div class="col-auto">
                        <div class="border border-black border-3 mb-3">
                            <form action="ControlServlet" method="post" enctype="multipart/form-data">
                                <div class="m-3">
                                    <p>
                                        <label for="formFileSm" class="form-label">Clave</label>
                                        <input id="clav" class="form-control form-control-sm" type="text" name="clave">
                                    </p>
                                    <p>
                                        <label for="formFileSm" class="form-label">Nombre</label>
                                        <input id="nom" class="form-control form-control-sm" type="text" name="nombre">
                                    </p>
                                    <p>
                                        <label for="formFileSm" class="form-label">Logotipo</label>
                                        <input id="log" class="form-control form-control-sm" name="logotipo" type="file" accept="image/*"> 
                                    </p>
                                    <div class="m-3">
                                        <div class="d-grid gap-6 mx-auto">
                                            <button class="btn btn-secondary" type="reset">Limpiar</button>
                                        </div>
                                    </div>
                                    <div class="m-3">
                                        <div class="d-grid gap-6 mx-auto">
                                            <button id="btn_guardar" onclick="registrar()" class="btn btn-primary" type="sumit" name="accion" value="registrarEscuelas">Registrar</button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>
                                   
                    <div class="table-responsive col-md">
                        <table class="table table-striped border border-black border-3" id="escuelasTabla">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col">Clave</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Logotipo</th>
                                </tr>
                            </thead>
                            <tbody id="tabla">
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </article>
        <script type="text/javascript"> 
            function registrar(){
                var clav = document.getElementById("clav").value;
                var nom = document.getElementById("nom").value;      
                var fila="<tr><td>"+clav+"</td><td>"+nom+"</td><td>"+ +"</td></tr>";
                var btn = document.createElement("TR");
                    btn.innerHTML=fila;
                document.getElementById("tabla").appendChild(btn);
            }
        </script>
    </body>
</html>
