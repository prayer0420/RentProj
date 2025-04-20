package service.member;

import java.util.List;

import dto.Grade;

public interface GradeService {
	// 등급 전체 조회
    List<Grade> getAllGrades() throws Exception;      
    // 등급 수정
    void updateGrade(Grade grade) throws Exception;   
}
