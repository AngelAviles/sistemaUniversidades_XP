/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import dao.AlumnoJpaController;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import objetosNegocio.Alumno;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author angel
 */
@MultipartConfig
public class importarAlumnos extends HttpServlet {

//    private boolean isMultipart;
//    private String filePath;
//    private int maxFileSize = 50 * 1024;
//    private int maxMemSize = 4 * 1024;
//    private File file;
//
//    @Override
//    public void init() throws ServletException {
//        filePath = getServletContext().getInitParameter("file-upload");
//    }
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
        
        HttpSession session = request.getSession();

        Part filePart = request.getPart("archivo"); // Retrieves <input type="file" name="archivo">
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream fileContent = filePart.getInputStream();

        XSSFWorkbook wb = new XSSFWorkbook(fileContent);
        XSSFSheet sheet = wb.getSheetAt(0);

        int numFilas = sheet.getLastRowNum();

        EntityManagerFactory factory = Persistence.createEntityManagerFactory("sistemaUniversidades_XP_PU");
        AlumnoJpaController jpa = new AlumnoJpaController(factory);

        List alumnos = new ArrayList<Alumno>();

        for (int a = 0; a <= numFilas; a++) {
            Row fila = sheet.getRow(a);

            Alumno alumno = new Alumno(null,
                    fila.getCell(0).getStringCellValue(),
                    fila.getCell(1).getStringCellValue(),
                    fila.getCell(2).getStringCellValue(),
                    null);

            jpa.create(alumno);

            alumnos.add(alumno);
        }

        session.setAttribute("listaAlumnos", alumnos);
        response.sendRedirect("importarAlumnos.jsp");

//        // Check that we have a file upload request
//        isMultipart = ServletFileUpload.isMultipartContent(request);
//        response.setContentType("text/html");
//        java.io.PrintWriter out = response.getWriter();
//
//        if (!isMultipart) {
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet upload</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<p>No file uploaded</p>");
//            out.println("</body>");
//            out.println("</html>");
//            return;
//        }
//
//        DiskFileItemFactory factory = new DiskFileItemFactory();
//
//        // maximum size that will be stored in memory
//        factory.setSizeThreshold(maxMemSize);
//
//        // Location to save data that is larger than maxMemSize.
//        factory.setRepository(new File("c:\\temp"));
//
//        // Create a new file upload handler
//        ServletFileUpload upload = new ServletFileUpload(factory);
//
//        // maximum file size to be uploaded.
//        upload.setSizeMax(maxFileSize);
//
//        try {
//            // Parse the request to get file items.
//            List fileItems = upload.parseRequest(request);
//
//            // Process the uploaded file items
//            Iterator i = fileItems.iterator();
//
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet upload</title>");
//            out.println("</head>");
//            out.println("<body>");
//
//            while (i.hasNext()) {
//                FileItem fi = (FileItem) i.next();
//                if (!fi.isFormField()) {
//                    // Get the uploaded file parameters
//                    String fieldName = fi.getFieldName();
//                    String fileName = fi.getName();
//                    String contentType = fi.getContentType();
//                    boolean isInMemory = fi.isInMemory();
//                    long sizeInBytes = fi.getSize();
//
//                    // Write the file
//                    if (fileName.lastIndexOf("\\") >= 0) {
//                        file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
//                    } else {
//                        file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
//                    }
//                    fi.write(file);
//                    out.println("Uploaded Filename: " + fileName + "<br>");
//                }
//            }
//            out.println("</body>");
//            out.println("</html>");
//        } catch (Exception ex) {
//            System.out.println(ex);
//        }
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
