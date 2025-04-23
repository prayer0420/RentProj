package utils;

import dto.Member;
import dto.ParsedAddress;

import java.util.ArrayList;
import java.util.List;

public class AddressParser {

    // Member 객체에 저장된 문자열 주소 1~3개를 ParsedAddress 리스트로 변환
    public static List<ParsedAddress> parseAddresses(Member member) {
        List<ParsedAddress> list = new ArrayList<>();
        String[] raw = { member.getAddress1(), member.getAddress2(), member.getAddress3() };

        for (int i = 0; i < raw.length; i++) {
            if (raw[i] != null && !raw[i].isBlank()) {
                String[] parts = raw[i].split("@@");
                if (parts.length >= 4) {
                    ParsedAddress addr = new ParsedAddress();
                    addr.setAlias(parts[0]);
                    addr.setZipcode(parts[1]);
                    addr.setAddress(parts[2]);
                    addr.setDetail(parts[3]);
                    addr.setPhone(member.getPhone());
                    addr.setRecipient(member.getName());
                    addr.setDefaultAddress(i == 0); // address1이면 기본배송지
                    list.add(addr);
                }
            }
        }
        return list;
    }

    // alias, zipcode, address, detail을 조합해서 문자열로 생성
    public static String buildAddressString(String alias, String zipcode, String address, String detail) {
        return alias + "@@" + zipcode + "@@" + address + "@@" + detail;
    }
}
