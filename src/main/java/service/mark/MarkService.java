package service.mark;

import java.util.List;
import java.util.Map;

import utils.PageInfo;

public interface MarkService {
	boolean existsMark(Integer memberNo,Integer productNo) throws Exception;
	void insertMark(Integer memberNo,Integer productNo) throws Exception;
	void deleteMark(Integer memberNo,Integer productNo) throws Exception;
	
    List<Map<String, Object>> selectMyMarkList(Integer memberNo, PageInfo pageInfo) throws Exception;
    PageInfo getPageInfo(Integer memberNo, int page) throws Exception;

}
