package service.mark;

import java.util.List;
import java.util.Map;

import dto.Mark;
import utils.PageInfo;

public interface MarkService {
	boolean existsMark(Integer memberNo,Integer productNo) throws Exception;
	void insertMark(Mark mark) throws Exception;
	void deleteMark(Mark mark) throws Exception;
	
    List<Map<String, Object>> selectMyMarkList(Integer memberNo, PageInfo pageInfo) throws Exception;
    PageInfo getPageInfo(Integer memberNo, int page) throws Exception;
    
    int countMarkProduct (Integer productNo) throws Exception;

}
