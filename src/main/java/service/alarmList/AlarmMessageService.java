package service.alarmList;

import java.util.List;

import dto.AlarmMessage;

public interface AlarmMessageService {
	// 모든 알림 메시지 목록 조회
    List<AlarmMessage> getAllMessages();
    // 알림 메시지 등록
    boolean createMessage(AlarmMessage alarm);
    // 알림 메시지 수정
    boolean updateMessage(AlarmMessage alarm);
    // 알림 메시지 삭제
    boolean deleteMessages(List<Integer> noList);
    // 알림 메시지 단건 조회
    AlarmMessage getMessageByNo(int no);

}
