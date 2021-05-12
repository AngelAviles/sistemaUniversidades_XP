package servlets;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import control.ControlAlumno;
import dao.AlumnoJpaController;
import dao.exceptions.PreexistingEntityException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import objetosNegocio.Alumno;
import objetosNegocio.Calificacion;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author angel
 */
@MultipartConfig
@WebServlet(name = "importarCalificaciones", urlPatterns = {"/importarCalificaciones"})
public class importarCalificaciones extends HttpServlet {

    private ControlAlumno controlAlumno = new ControlAlumno();

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

        List[] alumnos = null;
        Boolean archivoInvalido = false;

        switch (getFileExtension(fileName)) {
            case "xlsx":
                alumnos = importarXLSX(fileContent);
                break;
            case "xls":
                alumnos = importarXLS(fileContent);
                break;
            case "csv": {
                try {
                    alumnos = importarCSV(fileContent);
                } catch (CsvValidationException ex) {
                    Logger.getLogger(importarCalificaciones.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            default: {
                archivoInvalido = true;
            }

        }

        session.setAttribute("listaCalificaciones", alumnos);
        session.setAttribute("archivoInvalido", archivoInvalido);
        response.sendRedirect("importarCalificaciones.jsp");
        //request.getRequestDispatcher("importarAlumnos.jsp").forward(request, response);

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

    public static String getFileExtension(String name) {
        int dotIndex = name.lastIndexOf('.');
        return (dotIndex == -1) ? "" : name.substring(dotIndex + 1);
    }

    private List[] importarXLSX(InputStream fileContent) throws IOException {
        XSSFWorkbook wb = new XSSFWorkbook(fileContent);
        XSSFSheet sheet = wb.getSheetAt(0);

        int numFilas = sheet.getLastRowNum();

        List calificaciones = new ArrayList<Calificacion>();
        List camposVacios = new ArrayList<Integer>();
        List calificacionesPreexistentes = new ArrayList<Integer>();
        List matriculaIncorrecta = new ArrayList<Integer>();
        List claveMateriaIncorrecta = new ArrayList<Integer>();
        List calificacionesIncorrectas = new ArrayList<Integer>();

        /*
        for (int a = 1; a <= numFilas; a++) {
            Row fila = sheet.getRow(a);

            if (fila != null) {
                if (fila.getCell(0) == null
                        || fila.getCell(1) == null
                        || fila.getCell(2) == null) {
                    camposVacios.add(new Integer(a + 1));
                } else {
                    if (validarCURP(fila.getCell(2).getStringCellValue())) {
                        if (validarNombre(fila.getCell(1).getStringCellValue())) {
                            if (validarMatricula(fila.getCell(0).getStringCellValue())) {
                                Alumno alumno = new Alumno(null,
                                        fila.getCell(0).getStringCellValue(),
                                        fila.getCell(1).getStringCellValue(),
                                        fila.getCell(2).getStringCellValue(),
                                        null);
                                try {
                                    controlAlumno.agregarAlumno(alumno);
                                    alumnos.add(alumno);
                                } catch (PreexistingEntityException ex) {
                                    alumnosPreexistentes.add(new Integer(a + 1));
                                }
                            } else {
                                alumnosMatriculaIncorrecta.add(new Integer(a + 1));
                            }
                        } else {
                            alumnosNombreIncorrecto.add(new Integer(a + 1));
                        }

                    } else {
                        alumnosCurpIncorrecta.add(new Integer(a + 1));
                    }
                }
            }
        }
         */
        return new List[]{calificaciones, camposVacios, calificacionesPreexistentes, matriculaIncorrecta, claveMateriaIncorrecta, calificacionesIncorrectas};
    }

    private List[] importarXLS(InputStream fileContent) throws IOException {
        Workbook wb = new HSSFWorkbook(fileContent);
        Sheet sheet = wb.getSheetAt(0);

        int numFilas = sheet.getLastRowNum();

        List calificaciones = new ArrayList<Calificacion>();
        List camposVacios = new ArrayList<Integer>();
        List calificacionesPreexistentes = new ArrayList<Integer>();
        List matriculaIncorrecta = new ArrayList<Integer>();
        List claveMateriaIncorrecta = new ArrayList<Integer>();
        List calificacionesIncorrectas = new ArrayList<Integer>();
        /*
        for (int a = 1; a <= numFilas; a++) {
            Row fila = sheet.getRow(a);
            if (fila != null) {
                if (fila.getCell(0) == null
                        || fila.getCell(1) == null
                        || fila.getCell(2) == null) {
                    alumnosCamposVacios.add(new Integer(a + 1));
                } else {
                    if (validarCURP(fila.getCell(2).getStringCellValue())) {
                        if (validarNombre(fila.getCell(1).getStringCellValue())) {
                            if (validarMatricula(fila.getCell(0).getStringCellValue())) {
                                Alumno alumno = new Alumno(null,
                                        fila.getCell(0).getStringCellValue(),
                                        fila.getCell(1).getStringCellValue(),
                                        fila.getCell(2).getStringCellValue(),
                                        null);
                                try {
                                    controlAlumno.agregarAlumno(alumno);
                                    alumnos.add(alumno);
                                } catch (PreexistingEntityException ex) {
                                    alumnosPreexistentes.add(new Integer(a + 1));
                                }
                            } else {
                                alumnosMatriculaIncorrecta.add(new Integer(a + 1));
                            }
                        } else {
                            alumnosNombreIncorrecto.add(new Integer(a + 1));
                        }

                    } else {
                        alumnosCurpIncorrecta.add(new Integer(a + 1));
                    }
                }

            }
        }
         */
        return new List[]{calificaciones, camposVacios, calificacionesPreexistentes, matriculaIncorrecta, claveMateriaIncorrecta, calificacionesIncorrectas};
    }

    private List[] importarCSV(InputStream fileContent) throws IOException, CsvValidationException {
        CSVReader csv = new CSVReader(new InputStreamReader(fileContent));

        String[] fila = null;

        List calificaciones = new ArrayList<Calificacion>();
        List camposVacios = new ArrayList<Integer>();
        List calificacionesPreexistentes = new ArrayList<Integer>();
        List matriculaIncorrecta = new ArrayList<Integer>();
        List claveMateriaIncorrecta = new ArrayList<Integer>();
        List calificacionesIncorrectas = new ArrayList<Integer>();

        int contador = 0;

        /*
        while ((fila = csv.readNext()) != null) {
            if (contador >= 1) {
                if (fila != null) {
                    if (fila[0].isEmpty()
                            || fila[1].isEmpty()
                            || fila[2].isEmpty()) {
                        alumnosCamposVacios.add(new Integer(contador + 1));
                    } else {
                        if (validarCURP(fila[2])) {
                            if (validarNombre(fila[1])) {
                                if (validarMatricula(fila[0])) {
                                    Alumno alumno = new Alumno(null,
                                            fila[0],
                                            fila[1],
                                            fila[2],
                                            null);
                                    try {
                                        controlAlumno.agregarAlumno(alumno);
                                        alumnos.add(alumno);
                                    } catch (PreexistingEntityException ex) {
                                        alumnosPreexistentes.add(new Integer(contador + 1));
                                    }
                                } else {
                                    alumnosMatriculaIncorrecta.add(new Integer(contador + 1));
                                }
                            } else {
                                alumnosNombreIncorrecto.add(new Integer(contador + 1));
                            }

                        } else {
                            alumnosCurpIncorrecta.add(new Integer(contador + 1));
                        }

                    }
                }
            }
            contador++;

        }
         */
        csv.close();

        return new List[]{calificaciones, camposVacios, calificacionesPreexistentes, matriculaIncorrecta, claveMateriaIncorrecta, calificacionesIncorrectas};
    }

    public boolean validarMatricula(String str) {
        return str.matches("^([0-9])*$");
    }

}
