package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.SubjectService;

@WebServlet("/manageSubjects")
public class ManageSubjectsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer teacherId = (int) session.getAttribute("userId"); 
        if (teacherId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String[] selectedSubjects = request.getParameterValues("subjects");
        
        List<Long> subjectIds = new ArrayList<>();
        if (selectedSubjects != null) {
            for (String id : selectedSubjects) {
            	subjectIds.add(Long.parseLong(id));
            }
        } else { System.out.println("NO selectedSubjects"); }

        SubjectService subjectService = new SubjectService();
        subjectService.updateTeacherSubjects(teacherId, subjectIds);

        response.sendRedirect(request.getContextPath() + "/teacher");
    }
}
