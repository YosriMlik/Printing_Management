package service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import hibernate.HibernateUtil;
import model.Subject;
import model.TeacherSubject;
import model.User;
public class SubjectService {

    public static Subject getSubjectById(Long subjectId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Subject subject = null;
        try {
            subject = session.get(Subject.class, subjectId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return subject;
    }

	public static List<Subject> getAllSubjects() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<Subject> query = session.createQuery("FROM Subject", Subject.class);
        List<Subject> subjects = query.getResultList();
        session.close();
        return subjects;
    }
	
	public void updateTeacherSubjects(Integer teacherId, List<Long> subjectIds) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();

        try {
            // Delete existing teacher subjects
            Query deleteQuery = session.createQuery("DELETE FROM TeacherSubject WHERE teacher.id = :teacherId");
            deleteQuery.setParameter("teacherId", teacherId);
            deleteQuery.executeUpdate();

            // Add new teacher subjects
            for (Long subjectId : subjectIds) {
                TeacherSubject teacherSubject = new TeacherSubject();
                teacherSubject.setTeacher(session.get(User.class, teacherId));
                teacherSubject.setSubject(session.get(Subject.class, subjectId));
                session.save(teacherSubject);
            }

            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
