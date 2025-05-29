package dao.mark;

import java.util.List;
import java.util.Map;

import dto.Mark;

public interface MarkDAO {
	boolean existsMark(Integer memberNo,Integer productNo) throws Exception;
	void insertMark(Mark mark) throws Exception;
	void deleteMark(Mark mark) throws Exception;
    List<Map<String, Object>> selectMyMarkList(Map<String, Object> param) throws Exception;
    int selectMarkCount(Integer memberNo) throws Exception;
    
    int countMarkProduct(Integer productNo) throws Exception;
	
}
