package com.echoloop.studentregistrationapp.dao;

import com.echoloop.studentregistrationapp.entity.Student;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.*;
import jakarta.transaction.Transactional;

import java.util.List;
@ApplicationScoped
public class StudentDAO {

    @PersistenceContext(unitName = "students")
    private EntityManager em;

    @Transactional
    public void save(Student student) {
        em.persist(student);
    }

    public List<Student> findAll() {
        TypedQuery<Student> query = em.createQuery("SELECT s FROM Student s", Student.class);
        return query.getResultList();
    }

    public Student findById(Integer id) {
        return em.find(Student.class, id);
    }

    @Transactional
    public void deleteById(Integer id) {
        Student student = em.find(Student.class, id);
        if (student != null) {
            em.remove(student);
        }
    }
}
