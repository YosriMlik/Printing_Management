package servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.hibernate.Session;
import org.hibernate.Transaction;

import hibernate.HibernateUtil;
import model.PrintingRequest;
import model.Subject;
import model.User;
import service.SubjectService;
import service.UserService;

@WebServlet("/addPrintingRequest")
@MultipartConfig
public class AddPrintingRequestServlet extends HttpServlet {
	private static final String UPLOAD_DIR = "C:\\Users\\YOSRI-PC\\Desktop\\JEE Project\\uploads";


	public static void savePrintingRequest(PrintingRequest printingRequest) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            session.save(printingRequest);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
        Long subjectId = Long.parseLong(request.getParameter("subjectId"));
        String document = request.getParameter("document");
        int numberOfPrints = Integer.parseInt(request.getParameter("numberOfPrints"));
        String dateString = request.getParameter("date");
        

        
        // -------------- GET FILE ----------------------------
        Part filePart = request.getPart("document"); 
        // Ensure the upload directory exists
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        // Extract the file name
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        // Create the file path
        String filePath = UPLOAD_DIR + File.separator + fileName;
        // Save the file to the file system
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            e.printStackTrace(); // Handle file upload error
        }
        // ---------------------------------------------------------------------


        // Create a SimpleDateFormat object to parse the date string
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate = null;
        try {
            // Parse the date string into a java.util.Date object
            utilDate = dateFormat.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace(); // Handle parsing exception appropriately
        }
        // Convert java.util.Date to java.sql.Date
        java.sql.Date theDate = null;
        if (utilDate != null) {
            theDate = new java.sql.Date(utilDate.getTime());
        }
        

        // Retrieve current user (teacher)
        Integer currentUserId = (Integer) request.getSession().getAttribute("userId");
        // Retrieve subject object based on subjectId
        Subject subject = SubjectService.getSubjectById(subjectId);

        // Create a new PrintingRequest object
        PrintingRequest printingRequest = new PrintingRequest();
        User teacher = UserService.getUserById(currentUserId); // Retrieve User object by ID
        printingRequest.setTeacher(teacher);
        printingRequest.setSubject(subject);
        printingRequest.setDocument(""+filePath);
        printingRequest.setFileName(""+fileName);
        printingRequest.setNumberOfPrints(numberOfPrints);
        printingRequest.setDate(theDate); // Set current date
        printingRequest.setCompleted(false); // Assuming it's not completed initially
        
        // Save the printing request to the database
        savePrintingRequest(printingRequest);

        // Redirect back to the teacher dashboard
        response.sendRedirect(request.getContextPath() + "/teacher");
    }
}
