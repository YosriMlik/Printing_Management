package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.PrintingRequest;
import model.Subject;
import service.SubjectService;
import service.UserService;

@WebServlet("/teacher")
public class TeacherServlet extends HttpServlet  {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("///////////////// Helloooo Teacher");
        
        // Ensure we have a session and role verification is done only once
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (BaseServlet.verifySession(request, response)) {
            // Proceed with your logic after session verification
            
            // Remove the verification flag to ensure fresh verification for future requests
            session.removeAttribute("sessionVerified");

            int teacherId = (int) session.getAttribute("userId");
            List<Subject> subjects = SubjectService.getAllSubjects();
            List<Subject> teacherSubjects = UserService.getTeacherSubjects(teacherId);
            List<PrintingRequest> printRequests = UserService.getTeacherPrintRequests(teacherId);

            request.setAttribute("subjects", subjects);
            request.setAttribute("teacherSubjects", teacherSubjects);
            request.setAttribute("printRequests", printRequests);

            RequestDispatcher dispatcher = request.getRequestDispatcher("teacher.jsp");
            dispatcher.forward(request, response);
        }
    }
}
