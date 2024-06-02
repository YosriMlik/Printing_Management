package service;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import hibernate.HibernateUtil;
import model.PrintingRequest;
import model.Subject;
import model.User;

public class UserService {
	
	public static User getUserById(int userId) {
	    Session session = HibernateUtil.getSessionFactory().openSession();
	    User user = null;
	    try {
	        user = session.get(User.class, userId);
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        session.close();
	    }
	    return user;
	}

    public void saveUser(User user) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.saveOrUpdate(user);
        tx.commit();
        session.close();
    }
    
    public static void changeActivation(int userId, String act) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
                
        try {
            transaction = session.beginTransaction();
            User user = session.get(User.class, userId);
            if(act.equals("a")) {
            	user.setActivated(true); 
            } else if(act.equals("d")) {
            	user.setActivated(false); 
            }
            session.update(user);
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
	
	public static List<User> getAllAdmins() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<User> query = session.createQuery("FROM User WHERE role = 'admin'", User.class);
        List<User> admins = query.getResultList();
        session.close();
        return admins;
    }

    public static List<User> getAllTeachers() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<User> query = session.createQuery("FROM User WHERE role = 'teacher'", User.class);
        List<User> teachers = query.getResultList();
        session.close();
        return teachers;
    }

    public static List<User> getAllPrintingAgents() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<User> query = session.createQuery("FROM User WHERE role = 'printing_agent'", User.class);
        List<User> printingAgents = query.getResultList();
        session.close();
        return printingAgents;
    }

    public static List<Subject> getTeacherSubjects(int teacherId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<Subject> query = session.createQuery(
                "SELECT ts.subject FROM TeacherSubject ts WHERE ts.teacher.id = :teacherId", Subject.class);
        query.setParameter("teacherId", teacherId);
        List<Subject> subjects = query.getResultList();
        session.close();
        return subjects;
    }

    public static List<PrintingRequest> getTeacherPrintRequests(int teacherId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Query<PrintingRequest> query = session.createQuery(
        		"FROM PrintingRequest WHERE teacher.id = :teacherId ORDER BY completed ASC, date ASC", PrintingRequest.class);
        query.setParameter("teacherId", teacherId);
        List<PrintingRequest> printRequests = query.getResultList();
        session.close();
        return printRequests;
    }
}
