package service.member;

import java.util.List;

import dao.grade.GradeDAO;
import dao.grade.GradeDAOImpl;
import dto.Grade;

public class GradeServiceImpl implements GradeService {
	
    private GradeDAO gradeDAO;

    public GradeServiceImpl() {
        gradeDAO = new GradeDAOImpl();
    }

	@Override
	public List<Grade> getAllGrades() throws Exception {
        return gradeDAO.selectAllGrades();
	}

	@Override
	public void updateGrade(Grade grade) throws Exception {
        gradeDAO.updateGrade(grade);

	}

}
