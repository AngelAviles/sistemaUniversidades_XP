package servlets;

import dao.UsuarioJpaController;
import java.io.IOException;
import java.io.PrintWriter;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jwt.InicioSesionJWT;
import objetosNegocio.Usuario;

public class validarSesion extends HttpServlet {

    EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
    UsuarioJpaController usuarioDAO = new UsuarioJpaController(factory);
    Usuario usuarioSesion = new Usuario();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet validarSesion</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet validarSesion at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion.equalsIgnoreCase("Ingresar")) {
            String usuario = request.getParameter("txtuser");
            String contrasenia = request.getParameter("txtpass");
            try {
                usuarioSesion = usuarioDAO.consultarUsuarioInicioSesion(usuario, contrasenia);
                request.setAttribute("usuario", usuario);
                InicioSesionJWT token = new InicioSesionJWT();
                String tokenUsuario = token.validar(usuarioSesion);
                request.setAttribute("token", tokenUsuario);
                request.getRequestDispatcher("pruebaGenerarKardexJSP.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("errorSesion", "Credenciales invalidas");
                response.setContentType("text/html;charset=UTF-8");
                response.sendRedirect("inicioSesion.jsp");
            }
        } else {
            request.getRequestDispatcher("inicioSesion.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
