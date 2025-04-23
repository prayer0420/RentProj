package service.alarmList;

import java.util.List;

import dao.alarmList.AlarmMessageDAO;
import dao.alarmList.AlarmMessageDAOImpl;
import dto.AlarmMessage;

public class AlarmMessageServiceImpl implements AlarmMessageService {
	
    // DAO 객체 생성
    private AlarmMessageDAO dao = new AlarmMessageDAOImpl();

    // 알림 메시지 전체 목록 조회
	@Override
	public List<AlarmMessage> getAllMessages() {
        return dao.selectAll();
	}
	// 알림 메시지 등록
	@Override
	public boolean createMessage(AlarmMessage alarm) {
        int result = dao.insert(alarm);
        return result > 0;
	}
    // 알림 메시지 수정
	@Override
	public boolean updateMessage(AlarmMessage alarm) {
        return dao.update(alarm) > 0;
	}
	
	// 알림 메시지 삭제
	// 반환 결과(삭제된 행 수)가 0보다 크면 true, 아니면 false
	@Override
	public boolean deleteMessages(List<Integer> noList) {
        int result = dao.delete(noList);
        return result > 0;
	}
    // 알림 메시지 단건 조회 (수정 모달용)
	@Override
	public AlarmMessage getMessageByNo(int no) {
	    return dao.selectOne(no);
	}


}
  