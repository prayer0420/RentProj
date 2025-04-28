package dao.mark;

import java.util.List;
import java.util.Map;

import utils.PageInfo;

public interface MarkDAO {
	boolean existsMark(Integer memberNo,Integer productNo) throws Exception;
	void insertMark(Integer memberNo,Integer productNo) throws Exception;
	void deleteMark(Integer memberNo,Integer productNo) throws Exception;
    List<Map<String, Object>> selectMyMarkList(Map<String, Object> param) throws Exception;
    int selectMarkCount(Integer memberNo) throws Exception;
	
}
