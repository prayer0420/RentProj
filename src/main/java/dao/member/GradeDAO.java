package dao.member;

import java.util.List;

import dto.Grade;

public interface GradeDAO {
	// 등급 전체 조회
    List<Grade> selectAllGrades() throws Exception;      
    // 등급 정보 수정
    void updateGrade(Grade grade) throws Exception;           
}
