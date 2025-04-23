package service.mark;

import dto.Mark;

public interface MarkService {
	boolean existsMark(Integer memberNo,Integer productNo) throws Exception;
	void insertMark(Integer memberNo,Integer productNo) throws Exception;
	void deleteMark(Integer memberNo,Integer productNo) throws Exception;

}
